# Bounding async work

Put a time limit, a number of attempts, a degree of parallelism or a size limit on async work,
and know what happens on cancellation and on errors.

## Time limits

``withTimeout(_:tolerance:clock:operation:)`` runs the operation in a child task next to a timer:

```swift
do {
    let profile = try await withTimeout(.seconds(5)) {
        try await api.profile()
    }
    show(profile)
} catch is TimeoutError {
    showRetryButton()
}
```

- The first of the two to finish decides the result; the other is cancelled.
- Cancellation is cooperative. After the limit, the call waits for the operation to return.
  `URLSession`, `Task.sleep` and most system APIs return at once when cancelled; a loop of your
  own should call `try Task.checkCancellation()`.
- A limit of zero or less throws ``TimeoutError`` without starting the operation.
- The operation may be isolated to an actor: `withTimeout(.seconds(1)) { @MainActor in … }` runs
  it on the main actor.
- Pass `clock: SuspendingClock()` to stop counting while the device sleeps.

## Retries

``withRetry(_:clock:isolation:shouldRetry:operation:)`` runs the operation up to
``RetryPolicy/maxAttempts`` times:

```swift
let policy = RetryPolicy(maxAttempts: 5, initialDelay: .milliseconds(300), maxDelay: .seconds(10))
let feed = try await withRetry(policy, shouldRetry: { ($0 as? URLError)?.code != .cancelled }) { attempt in
    try await api.feed()
}
```

The wait after failure _n_ is `initialDelay × multiplier^(n − 1)`, at most `maxDelay`, minus a
random part of up to `jitter`. ``RetryPolicy/delay(afterAttempt:randomFraction:)`` computes it
without randomness, for tests and logs.

The operation runs on the caller's actor, so it may use that actor's state. `CancellationError`
is never retried, and cancelling the task during a wait ends the call at once.

``RetryPolicy`` corrects its values when it is created, so a policy built from remote
configuration cannot loop forever or trap:

| Value                                                     | Corrected to          |
| --------------------------------------------------------- | --------------------- |
| `maxAttempts` below 1 or above ``RetryPolicy/attemptLimit`` | 1 or 100              |
| A negative `initialDelay` or `maxDelay`                   | `.zero`               |
| A `multiplier` below 1, infinite or NaN                   | 1                     |
| A `jitter` outside 0...1                                  | 0 or 1; NaN becomes 0 |

## Parallel work with a limit

``Swift/Sequence/concurrentMap(maxConcurrency:_:)`` starts at most `maxConcurrency` transforms at
once and returns the results in the order of the sequence:

```swift
let thumbnails = try await photos.concurrentMap(maxConcurrency: 4) { photo in
    try await renderer.thumbnail(for: photo)
}
```

- A new transform starts when a running one returns.
- The first error cancels the running transforms, no new one starts, and the error is thrown
  with its own type. With a transform that cannot throw, the method does not throw either.
- Like `map`, it reads the whole sequence and keeps every result in memory.
- ``Swift/Sequence/concurrentCompactMap(maxConcurrency:_:)`` drops `nil` results and
  ``Swift/Sequence/concurrentForEach(maxConcurrency:_:)`` returns nothing.

## Collecting with a limit

`Array(asyncSequence)` and a `for await` loop that appends keep reading as long as the sequence
produces elements. ``_Concurrency/AsyncSequence/collect(limit:isolation:)`` stops at element
`limit + 1` and throws ``CollectLimitExceededError``:

```swift
let lines = try await fileURL.lines.collect(limit: 10_000)
```

For bytes, ``_Concurrency/AsyncSequence/collectData(limit:isolation:)`` returns `Data`.

## Downloads with a size limit

``Foundation/URLSession/data(for:limit:)`` works like `data(for:)` with a limit on the body:

```swift
do {
    let (data, response) = try await URLSession.shared.data(for: request, limit: 2_000_000)
    try handle(data, response)
} catch let error as ResponseTooLargeError {
    report(limit: error.limit, announced: error.expectedLength)
}
```

A `Content-Length` above the limit is refused before the body is read. A body without a length,
or longer than its announced length, is stopped at byte `limit + 1`. In both cases the transfer
is cancelled.
