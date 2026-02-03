import Foundation

// MARK: - Array Random Extensions

public extension Array {
    
    // MARK: - Random Element Selection
    
    /// Returns random element or nil if empty.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].randomElementOrNil    // Random element or nil
    /// ```
    var randomElementOrNil: Element? {
        return isEmpty ? nil : self[Int.random(in: 0..<count)]
    }
    
    /// Returns random element with specific generator.
    ///
    /// - Parameter generator: Random number generator.
    /// - Returns: Random element or nil.
    mutating func randomElement<T: RandomNumberGenerator>(using generator: inout T) -> Element? {
        return isEmpty ? nil : self[Int.random(in: 0..<count, using: &generator)]
    }
    
    /// Returns multiple random elements.
    ///
    /// - Parameter count: Number of elements to return.
    /// - Returns: Array of random elements (may contain duplicates).
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].randomElements(count: 3)    // e.g., [2, 5, 2]
    /// ```
    func randomElements(count: Int) -> [Element] {
        guard count > 0 && !isEmpty else { return [] }
        return (0..<count).compactMap { _ in randomElement() }
    }
    
    /// Returns unique random elements.
    ///
    /// - Parameter count: Number of elements to return.
    /// - Returns: Array of unique random elements.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].randomUniqueElements(count: 3)    // e.g., [2, 5, 1]
    /// ```
    func randomUniqueElements(count: Int) -> [Element] {
        guard count > 0 else { return [] }
        return Array(shuffled().prefix(Swift.min(count, self.count)))
    }
    
    /// Returns random sample without replacement.
    ///
    /// - Parameter sampleSize: Size of sample.
    /// - Returns: Random sample.
    func sample(size sampleSize: Int) -> [Element] {
        return randomUniqueElements(count: sampleSize)
    }
    
    // MARK: - Weighted Random Selection
    
    /// Returns random element based on weights.
    ///
    /// - Parameter weights: Array of weights (must match element count).
    /// - Returns: Weighted random element or nil.
    ///
    /// ```swift
    /// ["rare", "common", "epic"].weightedRandomElement(weights: [1, 5, 2])
    /// // "common" is 5x more likely than "rare"
    /// ```
    func weightedRandomElement(weights: [Double]) -> Element? {
        guard count == weights.count && !isEmpty else { return nil }
        
        let totalWeight = weights.reduce(0, +)
        guard totalWeight > 0 else { return nil }
        
        var random = Double.random(in: 0..<totalWeight)
        
        for (index, weight) in weights.enumerated() {
            random -= weight
            if random <= 0 {
                return self[index]
            }
        }
        
        return last
    }
    
    /// Returns multiple weighted random elements.
    ///
    /// - Parameters:
    ///   - count: Number of elements to return.
    ///   - weights: Array of weights.
    /// - Returns: Array of weighted random elements.
    func weightedRandomElements(count: Int, weights: [Double]) -> [Element] {
        return (0..<count).compactMap { _ in weightedRandomElement(weights: weights) }
    }
    
    // MARK: - Shuffling
    
    /// Returns shuffled array.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].shuffledArray    // e.g., [3, 1, 5, 2, 4]
    /// ```
    var shuffledArray: [Element] {
        return shuffled()
    }
    
    /// Shuffles array in place using Fisher-Yates algorithm.
    mutating func shuffleInPlace() {
        guard count > 1 else { return }
        
        for i in stride(from: count - 1, to: 0, by: -1) {
            let j = Int.random(in: 0...i)
            swapAt(i, j)
        }
    }
    
    /// Returns partially shuffled array.
    ///
    /// - Parameter shufflePercentage: Percentage of elements to shuffle (0-100).
    /// - Returns: Partially shuffled array.
    func partiallyShuffled(percentage shufflePercentage: Int) -> [Element] {
        guard shufflePercentage > 0 else { return self }
        guard shufflePercentage < 100 else { return shuffled() }
        
        var result = self
        let elementsToShuffle = max(1, count * shufflePercentage / 100)
        let indicesToShuffle = (0..<count).shuffled().prefix(elementsToShuffle)
        
        let shuffledIndices = indicesToShuffle.shuffled()
        for (original, shuffled) in zip(indicesToShuffle, shuffledIndices) {
            result[original] = self[shuffled]
        }
        
        return result
    }
    
    // MARK: - Random Permutations
    
    /// Returns random permutation of specified length.
    ///
    /// - Parameter length: Length of permutation.
    /// - Returns: Random permutation.
    func randomPermutation(length: Int) -> [Element] {
        return randomUniqueElements(count: Swift.min(length, count))
    }
    
    /// Returns all possible pairs in random order.
    var randomPairs: [(Element, Element)] {
        guard count >= 2 else { return [] }
        
        var pairs: [(Element, Element)] = []
        for i in 0..<count {
            for j in (i + 1)..<count {
                pairs.append((self[i], self[j]))
            }
        }
        
        return pairs.shuffled()
    }
    
    // MARK: - Random Splitting
    
    /// Splits array into random groups.
    ///
    /// - Parameter groupCount: Number of groups.
    /// - Returns: Array of random groups.
    func randomSplit(into groupCount: Int) -> [[Element]] {
        guard groupCount > 0 else { return [] }
        guard groupCount < count else { return map { [$0] } }
        
        let shuffled = self.shuffled()
        var groups: [[Element]] = Array(repeating: [], count: groupCount)
        
        for (index, element) in shuffled.enumerated() {
            groups[index % groupCount].append(element)
        }
        
        return groups
    }
    
    /// Splits array randomly with specified ratio.
    ///
    /// - Parameter ratio: Ratio for first group (0-1).
    /// - Returns: Tuple of two arrays.
    ///
    /// ```swift
    /// data.randomSplit(ratio: 0.8)    // (80% training, 20% testing)
    /// ```
    func randomSplit(ratio: Double) -> (first: [Element], second: [Element]) {
        let shuffled = self.shuffled()
        let splitIndex = Int(Double(count) * ratio)
        
        return (
            Array(shuffled.prefix(splitIndex)),
            Array(shuffled.dropFirst(splitIndex))
        )
    }
    
    // MARK: - Random Insertion
    
    /// Inserts element at random position.
    ///
    /// - Parameter element: Element to insert.
    /// - Returns: New array with element inserted.
    func randomlyInserted(_ element: Element) -> [Element] {
        var result = self
        let index = Int.random(in: 0...count)
        result.insert(element, at: index)
        return result
    }
    
    /// Inserts element at random position in place.
    ///
    /// - Parameter element: Element to insert.
    mutating func randomlyInsert(_ element: Element) {
        insert(element, at: Int.random(in: 0...count))
    }
    
    // MARK: - Random Removal
    
    /// Removes and returns random element.
    ///
    /// - Returns: Removed element or nil if empty.
    @discardableResult
    mutating func removeRandomElement() -> Element? {
        guard !isEmpty else { return nil }
        return remove(at: Int.random(in: 0..<count))
    }
    
    /// Removes random elements.
    ///
    /// - Parameter count: Number of elements to remove.
    /// - Returns: Removed elements.
    @discardableResult
    mutating func removeRandomElements(count: Int) -> [Element] {
        guard count > 0 else { return [] }
        
        var removed: [Element] = []
        for _ in 0..<Swift.min(count, self.count) {
            if let element = removeRandomElement() {
                removed.append(element)
            }
        }
        
        return removed
    }
}

// MARK: - Random Array Generation

public extension Array where Element: FixedWidthInteger {
    
    /// Creates array of random integers.
    ///
    /// - Parameters:
    ///   - count: Number of elements.
    ///   - range: Range of values.
    /// - Returns: Array of random integers.
    static func random(count: Int, in range: ClosedRange<Element>) -> [Element] {
        return (0..<count).map { _ in Element.random(in: range) }
    }
}

public extension Array where Element == Double {
    
    /// Creates array of random doubles.
    ///
    /// - Parameters:
    ///   - count: Number of elements.
    ///   - range: Range of values.
    /// - Returns: Array of random doubles.
    static func random(count: Int, in range: ClosedRange<Double> = 0...1) -> [Double] {
        return (0..<count).map { _ in Double.random(in: range) }
    }
    
    /// Creates array of normally distributed random values.
    ///
    /// - Parameters:
    ///   - count: Number of elements.
    ///   - mean: Mean of distribution.
    ///   - standardDeviation: Standard deviation.
    /// - Returns: Array of normally distributed values.
    static func randomNormal(count: Int, mean: Double = 0, standardDeviation: Double = 1) -> [Double] {
        return (0..<count).map { _ in
            // Box-Muller transform
            let u1 = Double.random(in: Double.ulpOfOne..<1)
            let u2 = Double.random(in: 0..<1)
            let z = sqrt(-2 * log(u1)) * cos(2 * .pi * u2)
            return z * standardDeviation + mean
        }
    }
}

public extension Array where Element == Bool {
    
    /// Creates array of random booleans.
    ///
    /// - Parameters:
    ///   - count: Number of elements.
    ///   - truePercentage: Percentage of true values (0-100).
    /// - Returns: Array of random booleans.
    static func random(count: Int, truePercentage: Int = 50) -> [Bool] {
        return (0..<count).map { _ in Int.random(in: 0..<100) < truePercentage }
    }
}
