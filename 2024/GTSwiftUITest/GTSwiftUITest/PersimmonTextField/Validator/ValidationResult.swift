public struct ValidationResult {
    public var isValid: Bool
    public var message: String?
    
    public init(
        isValid: Bool,
        message: String? = nil
    ) {
        
        self.isValid = isValid
        self.message = message
    }
}
