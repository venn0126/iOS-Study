import SwiftUI

extension PersimmonTextField {
    
    public func characterLimit(_ limit: Int?) -> PersimmonTextField {
        var view = self
        view.characterLimit = limit
        return view
    }
    
    public func font(_ font: UIFont) -> some View {
        var view = self
        view.font = font
        return view
    }
    
    public func foregroundColor(_ color: Color) -> PersimmonTextField {
        var view = self
        view.foregroundColor = UIColor(color)
        return view
    }
    
    public func accentColor(_ accentColor: Color) -> PersimmonTextField {
        var view = self
        view.accentColor = UIColor(accentColor)
        return view
    }
    
    public func multilineTextAlignment(_ alignment: TextAlignment) -> PersimmonTextField {
        var view = self
        switch alignment {
        case .leading:
            view.textAlignment = layoutDirection ~= .leftToRight ? .left : .right
        case .trailing:
            view.textAlignment = layoutDirection ~= .leftToRight ? .right : .left
        case .center:
            view.textAlignment = .center
        }
        return view
    }
    
    public func textContentType(_ textContentType: UITextContentType?) -> PersimmonTextField {
        var view = self
        view.contentType = textContentType
        return view
    }
    
    public func disableAutocorrection(_ disable: Bool) -> PersimmonTextField {
        var view = self
        view.autocorrection = disable ? .no : .yes
        return view
    }
    
    public func autocapitalization(_ style: UITextAutocapitalizationType) -> PersimmonTextField {
        var view = self
        view.autocapitalization = style
        return view
    }
    
    public func keyboardType(_ type: UIKeyboardType) -> PersimmonTextField {
        var view = self
        view.keyboardType = type
        return view
    }
    
    public func returnKeyType(_ type: UIReturnKeyType) -> PersimmonTextField {
        var view = self
        view.returnKeyType = type
        return view
    }
    
    public func isSecure(_ isSecure: Bool) -> PersimmonTextField {
        var view = self
        view.isSecure = isSecure
        return view
    }
    
    public func shouldInsertMaskedText(_ shouldInsertMaskedText: Bool) -> PersimmonTextField {
        var view = self
        view.shouldInsertMaskedText = shouldInsertMaskedText
        return view
    }
    
    public func clearsOnBeginEditing(_ shouldClear: Bool) -> PersimmonTextField {
        var view = self
        view.clearsOnBeginEditing = shouldClear
        return view
    }
    
    public func clearsOnInsertion(_ shouldClear: Bool) -> PersimmonTextField {
        var view = self
        view.clearsOnInsertion = shouldClear
        return view
    }
    
    public func showsClearButton(_ showsButton: Bool) -> PersimmonTextField {
        var view = self
        view.clearButtonMode = showsButton ? .always : .never
        return view
    }
    
    public func disabled(_ disabled: Bool) -> PersimmonTextField {
        var view = self
        view.isUserInteractionEnabled = !disabled
        return view
    }
    
    public func passwordRules(_ rules: UITextInputPasswordRules) -> PersimmonTextField {
        var view = self
        view.isSecure = true
        view.passwordRules = rules
        return view
    }
    
    public func smartDashes(_ smartDashes: Bool) -> PersimmonTextField {
        var view = self
        view.smartDashesType = smartDashes ? .yes : .no
        return view
    }
    
    public func smartInsertDelete(_ smartInsertDelete: Bool) -> PersimmonTextField {
        var view = self
        view.smartInsertDeleteType = smartInsertDelete ? .yes : .no
        return view
    }
    
    public func smartQuotes(_ smartQuotes: Bool) -> PersimmonTextField {
        var view = self
        view.smartQuotesType = smartQuotes ? .yes : .no
        return view
    }
    
    public func spellChecking(_ spellChecking: Bool) -> PersimmonTextField {
        var view = self
        view.spellCheckingType = spellChecking ? .yes : .no
        return view
    }
    
    public func inputAccessoryView(_ inputAccessoryViewFactory: InputAccessoryViewFactoryProtocol) -> PersimmonTextField {
        var view = self
        view.inputAccessoryViewFactory = inputAccessoryViewFactory
        return view
    }
    
    public func validations(
        _ validations: [ValidatorProtocol],
        isValidateAfterFinishEditing: Bool,
        isValidateWhileEditing: Bool,
        onValidate: @escaping ((ValidationResult) -> Void)
    ) -> PersimmonTextField {
        
        var view = self
        view.isValidateAfterFinishEditing = isValidateAfterFinishEditing
        view.isValidateWhileEditing = isValidateWhileEditing
        view.validations = validations
        view.onValidate = onValidate
        return view
    }
    
    public func masks(_ masks: String...) -> PersimmonTextField {
        var view = self
        view.inputListener = .init(affineFormats: masks)
        return view
    }
    
    public func onEditingBegan(perform action: (() -> Void)?) -> PersimmonTextField {
        var view = self
        if let action {
            view.didBeginEditing = action
        }
        return view
        
    }
    
    public func onEdit(perform action: (() -> Void)?) -> PersimmonTextField {
        var view = self
        if let action {
            view.didChange = action
        }
        return view
        
    }
    
    public func onEditingEnded(perform action: (() -> Void)?) -> PersimmonTextField {
        var view = self
        if let action {
            view.didEndEditing = action
        }
        return view
    }
    
    public func onReturn(perform action: (() -> Void)?) -> PersimmonTextField {
        var view = self
        if let action {
            view.shouldReturn = action
        }
        return view
    }
    
    public func onClear(perform action: (() -> Void)?) -> PersimmonTextField {
        var view = self
        if let action {
            view.shouldClear = action
        }
        return view
    }
    
}
