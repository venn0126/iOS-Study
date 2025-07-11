public protocol ValidatorProtocol {
    func validate<T>(_ value: T) -> ValidationResult
}
