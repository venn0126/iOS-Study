extension Array: ValidatorProtocol where Element == ValidatorProtocol {
    public func validate<T>(_ value: T) -> ValidationResult {
        for validator in self {
            let result = validator.validate(value)
            guard result.isValid else {
                return result
            }
        }
        return .init(isValid: true, message: nil)
    }
}

public extension Array where Element: ValidatorProtocol {
    func validate<T>(_ value: T) -> ValidationResult {
        (self as [ValidatorProtocol]).validate(value)
    }
}
