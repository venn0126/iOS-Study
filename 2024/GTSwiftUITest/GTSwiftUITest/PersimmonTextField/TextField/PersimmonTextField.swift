import SwiftUI
import InputMask

public struct PersimmonTextField<Field: Hashable>: UIViewRepresentable {
    
    @Environment(\.layoutDirection) var layoutDirection: LayoutDirection
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var didBeginEditing: () -> Void = { }
    var didChange: () -> Void = { }
    var didEndEditing: () -> Void = { }
    var shouldReturn: () -> Void = { }
    var shouldClear: () -> Void = { }
    
    var onValidate: (ValidationResult) -> Void = { _ in }
    
    var placeholder: String
    var font: UIFont?
    var foregroundColor: UIColor?
    var accentColor: UIColor?
    var textAlignment: NSTextAlignment?
    var contentType: UITextContentType?
    
    var autocorrection: UITextAutocorrectionType = .default
    var autocapitalization: UITextAutocapitalizationType = .sentences
    var keyboardType: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    var characterLimit: Int? = nil
    
    var shouldInsertMaskedText = true
    var isSecure = false
    var isUserInteractionEnabled = true
    var isValidateAfterFinishEditing = false
    var isValidateWhileEditing = false
    var clearsOnBeginEditing = false
    var clearsOnInsertion = false
    var clearButtonMode: UITextField.ViewMode = .never
    
    var passwordRules: UITextInputPasswordRules?
    var smartDashesType: UITextSmartDashesType = .default
    var smartInsertDeleteType: UITextSmartInsertDeleteType = .default
    var smartQuotesType: UITextSmartQuotesType = .default
    var spellCheckingType: UITextSpellCheckingType = .default
    
    var validations: [ValidatorProtocol] = []
    var inputAccessoryViewFactory: InputAccessoryViewFactoryProtocol?
    var inputListener: MaskedTextInputListener?
    
    @Binding private var text: String
    @Binding private var focusedField: Field?
    private let equalField: Field
    
    private var isFirstResponder: Bool {
        focusedField == equalField
    }
    
    public init(
        _ placeholder: String,
        text: Binding<String>,
        focusedField: Binding<Field?>,
        equals: Field
    ) {
        
        self.placeholder = placeholder
        equalField = equals
        _text = text
        _focusedField = focusedField
    }
    
    private func configure(_ textField: UITextField) {
        
        textField.text = text
        textField.placeholder = placeholder
        textField.font = font
        textField.textColor = foregroundColor
        
        if let textAlignment = textAlignment {
            textField.textAlignment = textAlignment
        }
        
        textField.clearsOnBeginEditing = clearsOnBeginEditing
        textField.clearsOnInsertion = clearsOnInsertion
        
        if let contentType = contentType {
            textField.textContentType = contentType
        }
        
        if let accentColor = accentColor {
            textField.tintColor = accentColor
        }
        
        textField.clearButtonMode = clearButtonMode
        textField.autocorrectionType = autocorrection
        textField.autocapitalizationType = autocapitalization
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textField.passwordRules = passwordRules
        textField.smartDashesType = smartDashesType
        textField.smartInsertDeleteType = smartInsertDeleteType
        textField.smartQuotesType = smartQuotesType
        textField.spellCheckingType = spellCheckingType
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        if inputListener == nil {
            textField.delegate = context.coordinator
        } else {
            textField.delegate = context.coordinator.inputListener
        }
        
        configure(textField)
        
        textField.isSecureTextEntry = isSecure
        
        if isFirstResponder {
            textField.becomeFirstResponder()
        }
        
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textFieldDidChange),
            for: .editingChanged
        )
        
        if let inputAccessoryViewFactory {
            context.coordinator.inputAccessoryViewFactory = inputAccessoryViewFactory
            textField.inputAccessoryView = inputAccessoryViewFactory.inputAccessoryView()
        }
        
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        configure(uiView)
        
        if shouldInsertMaskedText && !isFirstResponder {
            inputListener?.put(text: uiView.text ?? "", into: uiView)
        }
        
        if isSecure != uiView.isSecureTextEntry {
            var start: UITextPosition?
            var end: UITextPosition?
            
            if let selectedRange = uiView.selectedTextRange {
                start = selectedRange.start
                end = selectedRange.end
            }
            
            uiView.isSecureTextEntry = isSecure
            if isSecure && isFirstResponder {
                if let currentText = uiView.text {
                    uiView.text?.removeAll()
                    uiView.insertText(currentText)
                }
            }
            if isFirstResponder {
                if let start = start, let end = end {
                    uiView.selectedTextRange = uiView.textRange(from: start, to: end)
                }
            }
        }
        
        if isFirstResponder {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            text: $text,
            focusedField: $focusedField,
            equalField: equalField,
            characterLimit: characterLimit,
            isValidateAfterFinishEditing: isValidateAfterFinishEditing,
            isValidateWhileEditing: isValidateWhileEditing,
            validations: validations,
            inputListener: inputListener,
            didBeginEditing: didBeginEditing,
            didChange: didChange,
            didEndEditing: didEndEditing,
            shouldReturn: shouldReturn,
            shouldClear: shouldClear,
            onValidate: onValidate
        )
    }
    
    public final class Coordinator: NSObject, UITextFieldDelegate {
        
        var inputListener: MaskedTextInputListener?
        var inputAccessoryViewFactory: InputAccessoryViewFactoryProtocol?
        
        @Binding private var text: String
        @Binding private var focusedField: Field?
        
        private let equalField: Field
        
        private var didBeginEditing: () -> Void
        private var didChange: () -> Void
        private var didEndEditing: () -> Void
        private var shouldReturn: () -> Void
        private var shouldClear: () -> Void
        private var onValidate: (ValidationResult) -> Void
        
        private var characterLimit: Int?
        private var isValidateAfterFinishEditing: Bool
        private var isValidateWhileEditing: Bool
        private var validations: [ValidatorProtocol]
        
        private var wasEdited = false
        private var isFirstResponder: Bool {
            focusedField == equalField
        }
        
        init(
            text: Binding<String>,
            focusedField: Binding<Field?>,
            equalField: Field,
            characterLimit: Int?,
            isValidateAfterFinishEditing: Bool,
            isValidateWhileEditing: Bool,
            validations: [ValidatorProtocol],
            inputListener: MaskedTextInputListener?,
            didBeginEditing: @escaping () -> Void,
            didChange: @escaping () -> Void,
            didEndEditing: @escaping () -> Void,
            shouldReturn: @escaping () -> Void,
            shouldClear: @escaping () -> Void,
            onValidate: @escaping (ValidationResult) -> Void
        ) {
            
            _text = text
            _focusedField = focusedField
            self.equalField = equalField
            self.characterLimit = characterLimit
            self.isValidateAfterFinishEditing = isValidateAfterFinishEditing
            self.isValidateWhileEditing = isValidateWhileEditing
            self.validations = validations
            self.didBeginEditing = didBeginEditing
            self.didChange = didChange
            self.didEndEditing = didEndEditing
            self.shouldReturn = shouldReturn
            self.shouldClear = shouldClear
            self.onValidate = onValidate
            
            super.init()
            
            guard let inputListener else { return }
            
            self.inputListener = inputListener
            self.inputListener?.textFieldDelegate = self
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                text = textField.text ?? ""
                
                if !isFirstResponder {
                    focusedField = equalField
                }
                
                if textField.clearsOnBeginEditing {
                    text = ""
                }
                
                didBeginEditing()
            }
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
            didChange()
            
            if isValidateWhileEditing, wasEdited {
                validate(textField.text ?? "")
            }
            
            if !wasEdited {
                wasEdited = !text.isEmpty
            }
        }
        
        public func textFieldDidEndEditing(
            _ textField: UITextField,
            reason: UITextField.DidEndEditingReason
        ) {
            
            DispatchQueue.main.async { [self] in
                if isFirstResponder {
                    focusedField = equalField
                }
                
                didEndEditing()
                
                if isValidateAfterFinishEditing {
                    validate(textField.text ?? "")
                }
            }
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            focusedField = nil
            shouldReturn()
            return false
        }
        
        public func textFieldShouldClear(_ textField: UITextField) -> Bool {
            shouldClear()
            text = ""
            return false
        }
        
        public func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            
            if let limit = characterLimit, let text = textField.text {
                if text.count + string.count > limit {
                    return false
                }
            }
            
            return true
        }
        
        private func validate(_ text: String) {
            let result = validations.validate(text)
            DispatchQueue.main.async {
                self.onValidate(result)
            }
        }
        
    }
    
}
