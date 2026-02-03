import Foundation

// MARK: - Array Math Extensions for Numeric Types

public extension Array where Element: Numeric {
    
    // MARK: - Basic Statistics
    
    /// Returns sum of all elements.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].sum    // 15
    /// ```
    var sum: Element {
        return reduce(0, +)
    }
    
    /// Returns product of all elements.
    ///
    /// ```swift
    /// [1, 2, 3, 4].product    // 24
    /// ```
    var product: Element {
        guard !isEmpty else { return 0 }
        return reduce(1, *)
    }
}

// MARK: - Integer Extensions

public extension Array where Element: BinaryInteger {
    
    /// Returns average of all elements.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].average    // 3.0
    /// ```
    var average: Double {
        guard !isEmpty else { return 0 }
        return Double(sum) / Double(count)
    }
    
    /// Returns median value.
    ///
    /// ```swift
    /// [1, 3, 5, 7, 9].median    // 5.0
    /// [1, 2, 3, 4].median       // 2.5
    /// ```
    var median: Double {
        guard !isEmpty else { return 0 }
        
        let sorted = self.sorted()
        let middle = count / 2
        
        if count.isMultiple(of: 2) {
            return Double(sorted[middle - 1] + sorted[middle]) / 2.0
        } else {
            return Double(sorted[middle])
        }
    }
    
    /// Returns mode (most frequent value).
    var mode: Element? {
        guard !isEmpty else { return nil }
        return frequencies.max(by: { $0.value < $1.value })?.key
    }
    
    /// Returns range (max - min).
    var range: Element? {
        guard let min = self.min(), let max = self.max() else { return nil }
        return max - min
    }
    
    /// Returns variance.
    var variance: Double {
        guard count > 1 else { return 0 }
        let avg = average
        let squaredDiffs = map { pow(Double($0) - avg, 2) }
        return squaredDiffs.reduce(0, +) / Double(count)
    }
    
    /// Returns standard deviation.
    var standardDeviation: Double {
        return sqrt(variance)
    }
    
    /// Returns cumulative sum.
    ///
    /// ```swift
    /// [1, 2, 3, 4].cumulativeSum    // [1, 3, 6, 10]
    /// ```
    var cumulativeSum: [Element] {
        var result: [Element] = []
        var running: Element = 0
        
        for element in self {
            running += element
            result.append(running)
        }
        
        return result
    }
}

// MARK: - Floating Point Extensions

public extension Array where Element: FloatingPoint {
    
    /// Returns sum of all elements.
    var sum: Element {
        return reduce(0, +)
    }
    
    /// Returns average of all elements.
    var average: Element {
        guard !isEmpty else { return 0 }
        return sum / Element(count)
    }
    
    /// Returns median value.
    var median: Element {
        guard !isEmpty else { return 0 }
        
        let sorted = self.sorted()
        let middle = count / 2
        
        if count.isMultiple(of: 2) {
            return (sorted[middle - 1] + sorted[middle]) / 2
        } else {
            return sorted[middle]
        }
    }
    
    /// Returns variance.
    var variance: Element {
        guard count > 1 else { return 0 }
        let avg = average
        let squaredDiffs = map { ($0 - avg) * ($0 - avg) }
        return squaredDiffs.reduce(0, +) / Element(count)
    }
    
    /// Returns standard deviation.
    var standardDeviation: Element {
        return variance.squareRoot()
    }
    
    /// Returns cumulative sum.
    var cumulativeSum: [Element] {
        var result: [Element] = []
        var running: Element = 0
        
        for element in self {
            running += element
            result.append(running)
        }
        
        return result
    }
    
    /// Returns moving average with window size.
    ///
    /// - Parameter windowSize: Size of moving window.
    /// - Returns: Array of moving averages.
    func movingAverage(windowSize: Int) -> [Element] {
        guard windowSize > 0 && windowSize <= count else { return [] }
        
        var result: [Element] = []
        
        for i in windowSize...count {
            let window = self[(i - windowSize)..<i]
            let avg = window.reduce(0, +) / Element(windowSize)
            result.append(avg)
        }
        
        return result
    }
    
    /// Normalizes values to 0-1 range.
    var normalized: [Element] {
        guard let min = self.min(), let max = self.max(), min != max else {
            return map { _ in 0.5 }
        }
        
        let range = max - min
        return map { ($0 - min) / range }
    }
    
    /// Standardizes values (z-score normalization).
    var standardized: [Element] {
        let avg = average
        let std = standardDeviation
        
        guard std != 0 else { return map { _ in 0 } }
        return map { ($0 - avg) / std }
    }
}

// MARK: - Double Specific Extensions

public extension Array where Element == Double {
    
    /// Returns percentile value.
    ///
    /// - Parameter percentile: Percentile (0-100).
    /// - Returns: Value at percentile.
    func percentile(_ percentile: Double) -> Double {
        guard !isEmpty else { return 0 }
        guard percentile >= 0 && percentile <= 100 else { return 0 }
        
        let sorted = self.sorted()
        let index = (percentile / 100.0) * Double(count - 1)
        let lower = Int(index)
        let upper = min(lower + 1, count - 1)
        let fraction = index - Double(lower)
        
        return sorted[lower] * (1 - fraction) + sorted[upper] * fraction
    }
    
    /// Returns quartiles (Q1, Q2, Q3).
    var quartiles: (q1: Double, q2: Double, q3: Double) {
        return (percentile(25), percentile(50), percentile(75))
    }
    
    /// Returns interquartile range.
    var interquartileRange: Double {
        let q = quartiles
        return q.q3 - q.q1
    }
    
    /// Detects outliers using IQR method.
    ///
    /// - Parameter factor: IQR multiplier (default 1.5).
    /// - Returns: Indices of outliers.
    func outlierIndices(factor: Double = 1.5) -> [Int] {
        let q = quartiles
        let iqr = q.q3 - q.q1
        let lowerBound = q.q1 - factor * iqr
        let upperBound = q.q3 + factor * iqr
        
        return enumerated().compactMap { index, value in
            (value < lowerBound || value > upperBound) ? index : nil
        }
    }
    
    /// Returns values without outliers.
    func withoutOutliers(factor: Double = 1.5) -> [Double] {
        let outliers = Set(outlierIndices(factor: factor))
        return enumerated().compactMap { outliers.contains($0.offset) ? nil : $0.element }
    }
    
    /// Calculates correlation coefficient with another array.
    ///
    /// - Parameter other: Array to correlate with.
    /// - Returns: Pearson correlation coefficient (-1 to 1).
    func correlation(with other: [Double]) -> Double {
        guard count == other.count && count > 1 else { return 0 }
        
        let avgSelf = average
        let avgOther = other.average
        
        var numerator: Double = 0
        var denominatorSelf: Double = 0
        var denominatorOther: Double = 0
        
        for i in 0..<count {
            let diffSelf = self[i] - avgSelf
            let diffOther = other[i] - avgOther
            
            numerator += diffSelf * diffOther
            denominatorSelf += diffSelf * diffSelf
            denominatorOther += diffOther * diffOther
        }
        
        let denominator = sqrt(denominatorSelf * denominatorOther)
        return denominator == 0 ? 0 : numerator / denominator
    }
    
    /// Calculates covariance with another array.
    ///
    /// - Parameter other: Array to calculate covariance with.
    /// - Returns: Covariance value.
    func covariance(with other: [Double]) -> Double {
        guard count == other.count && count > 1 else { return 0 }
        
        let avgSelf = average
        let avgOther = other.average
        
        var sum: Double = 0
        for i in 0..<count {
            sum += (self[i] - avgSelf) * (other[i] - avgOther)
        }
        
        return sum / Double(count)
    }
}

// MARK: - Vector Operations

public extension Array where Element: FloatingPoint {
    
    /// Calculates dot product with another array.
    ///
    /// - Parameter other: Array to dot product with.
    /// - Returns: Dot product value.
    func dotProduct(with other: [Element]) -> Element {
        guard count == other.count else { return 0 }
        return zip(self, other).map(*).reduce(0, +)
    }
    
    /// Returns magnitude (length) of vector.
    var magnitude: Element {
        return dotProduct(with: self).squareRoot()
    }
    
    /// Returns unit vector (normalized to length 1).
    var unitVector: [Element] {
        let mag = magnitude
        guard mag != 0 else { return self }
        return map { $0 / mag }
    }
    
    /// Adds another array element-wise.
    ///
    /// - Parameter other: Array to add.
    /// - Returns: Element-wise sum.
    func adding(_ other: [Element]) -> [Element] {
        guard count == other.count else { return self }
        return zip(self, other).map(+)
    }
    
    /// Subtracts another array element-wise.
    ///
    /// - Parameter other: Array to subtract.
    /// - Returns: Element-wise difference.
    func subtracting(_ other: [Element]) -> [Element] {
        guard count == other.count else { return self }
        return zip(self, other).map(-)
    }
    
    /// Multiplies by scalar.
    ///
    /// - Parameter scalar: Scalar value.
    /// - Returns: Scaled array.
    func scaled(by scalar: Element) -> [Element] {
        return map { $0 * scalar }
    }
}
