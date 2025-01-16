struct CappedValue<T: Comparable & Numeric> {
  private var _current: T
  var current: T {
    get { _current }
    set { _current = min(_current, max) }
  }
  
  let max: T
  
  init(current: T, max: T) {
    self.max = max
    self._current = min(current, max)
  }
  
  mutating func reset() {
    self._current = max
  }
}

extension CappedValue: ExpressibleByIntegerLiteral where T == IntegerLiteralType {
  init(integerLiteral value: IntegerLiteralType) {
    self.max = value
    self._current = value
  }
}

extension CappedValue: ExpressibleByFloatLiteral where T == FloatLiteralType {
  init(floatLiteral value: FloatLiteralType) {
    self.max = value
    self._current = value
  }
}
