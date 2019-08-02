//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

//MARK:--- UITextField ----------
public extension CaamDau where Base: UITextField {
    @discardableResult
    func placeholder(_ p: String? = nil) -> CaamDau {
        base.placeholder = p
        return self
    }
    @discardableResult
    func placeholder(_ attributed: NSAttributedString? = nil) -> CaamDau {
        base.attributedPlaceholder = attributed
        return self
    }
    @discardableResult
    func border(_ style:UITextField.BorderStyle) -> CaamDau {
        base.borderStyle = style
        return self
    }
    @discardableResult
    func text(default attributes:[NSAttributedString.Key : Any]) -> CaamDau {
        base.defaultTextAttributes = attributes
        return self
    }
    @discardableResult
    func clear(onBeginEditing b:Bool) -> CaamDau {
        base.clearsOnBeginEditing = b
        return self
    }
    
    @discardableResult
    func clear(buttonMode b:UITextField.ViewMode) -> CaamDau {
        base.clearButtonMode = b
        return self
    }
    
    
    @discardableResult
    func adjusts(_ fontSizeToFitWidth:Bool) -> CaamDau {
        base.adjustsFontSizeToFitWidth = fontSizeToFitWidth
        return self
    }
    @discardableResult
    func minimumFont(_ size:CGFloat) -> CaamDau {
        base.minimumFontSize = size
        return self
    }
    @discardableResult
    func delegate(_ d:UITextFieldDelegate? = nil) -> CaamDau {
        base.delegate = d
        return self
    }
    @discardableResult
    func background(_ img:UIImage? = nil) -> CaamDau {
        base.background = img
        return self
    }
    @discardableResult
    func disabledBackground(_ img:UIImage? = nil) -> CaamDau {
        base.disabledBackground = img
        return self
    }
    @discardableResult
    func allows(editingTextAttributes b:Bool) -> CaamDau {
        base.allowsEditingTextAttributes = b
        return self
    }
    @discardableResult
    func typing(attributes b:[NSAttributedString.Key : Any]) -> CaamDau {
        base.typingAttributes = b
        return self
    }
    
    @discardableResult
    func left(view v:UIView) -> CaamDau {
        base.leftView = v
        return self
    }
    @discardableResult
    func left(viewMode v:UITextField.ViewMode) -> CaamDau {
        base.leftViewMode = v
        return self
    }
    @discardableResult
    func right(view v:UIView) -> CaamDau {
        base.rightView = v
        return self
    }
    @discardableResult
    func right(viewMode v:UITextField.ViewMode) -> CaamDau {
        base.rightViewMode = v
        return self
    }
    
    @discardableResult
    func returnKeyType(_ a:UIReturnKeyType) -> CaamDau {
        base.returnKeyType = a
        return self
    }
    
    @discardableResult
    func keyboardType(_ type:UIKeyboardType) -> CaamDau {
        base.keyboardType = type
        return self
    }
}


//MARK:--- UITextView ----------
public extension CaamDau where Base: UITextView {
    
    @discardableResult
    func delegate(_ d:UITextViewDelegate? = nil) -> CaamDau {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func allows(editingTextAttributes b:Bool) -> CaamDau {
        base.allowsEditingTextAttributes = b
        return self
    }
    @discardableResult
    func typing(attributes b:[NSAttributedString.Key : Any]) -> CaamDau {
        base.typingAttributes = b
        return self
    }
    
    @discardableResult
    func isEditable(_ e: Bool) -> CaamDau {
        base.isEditable = e
        return self
    }
    
    @discardableResult
    func isSelectable(_ s: Bool) -> CaamDau {
        base.isSelectable = s
        return self
    }
    
    @discardableResult
    func text(containerInset c: UIEdgeInsets) -> CaamDau {
        base.textContainerInset = c
        return self
    }
    
    @discardableResult
    func data(detectorTypes d: UIDataDetectorTypes) -> CaamDau {
        base.dataDetectorTypes = d
        return self
    }
    
    @discardableResult
    func returnKeyType(_ a:UIReturnKeyType) -> CaamDau {
        base.returnKeyType = a
        return self
    }
    
    @discardableResult
    func keyboardType(_ type:UIKeyboardType) -> CaamDau {
        base.keyboardType = type
        return self
    }
    
}

public class CD_TextDelegate: NSObject {
    class func textLimit(_ match:(regex:CD_RegEx, max:Int), text:String?, range: NSRange,  string: String) -> Bool {
        return CD_TextDelegate.textLimit((text: text, pattern: match.regex.patternValue, max: match.max), range: range, string: string)
    }
    class func textLimit(_ match:(text:String?, pattern:String, max:Int), range: NSRange,  string: String) -> Bool {
        guard let text = match.text  else { return true }
        guard let r = Range.init(range, in: text) else { return true }
        let new = text.replacingCharacters(in: r, with: string)
        guard new.count <= match.max else { return false }
        return CD_RegEx.match(new, pattern: match.pattern)
    }
    
    var textFieldEditing:((UITextField, UIControl.Event)->Void)?
    var textFieldShouldClear:(( UITextField) -> Bool)?
    var textFieldShouldReturn:((UITextField) -> Bool)?
    var textFieldShouldChangeCharacters:((UITextField, NSRange, String) -> Bool)?
    
    var textViewEditing:((UITextView, UIControl.Event)->Void)?
    var textViewShouldClear:(( UITextView) -> Bool)?
    var textViewShouldReturn:((UITextView) -> Bool)?
    var textViewShouldChangeText:((UITextView, NSRange, String) -> Bool)?
    
    init(textField editing:((UITextField, UIControl.Event)->Void)? = nil,
         shouldClear:(( UITextField) -> Bool)? = nil,
         shouldReturn:((UITextField) -> Bool)? = nil,
         shouldChangeCharacters:((UITextField, NSRange, String) -> Bool)? = nil) {
        textFieldEditing = editing
        textFieldShouldClear = shouldClear
        textFieldShouldReturn = shouldReturn
        textFieldShouldChangeCharacters = shouldChangeCharacters
    }
    
    init(textView editing:((UITextView, UIControl.Event)->Void)? = nil,
         shouldClear:(( UITextView) -> Bool)? = nil,
         shouldReturn:((UITextView) -> Bool)? = nil,
         shouldChangeText:((UITextView, NSRange, String) -> Bool)? = nil) {
        textViewEditing = editing
        textViewShouldClear = shouldClear
        textViewShouldReturn = shouldReturn
        textViewShouldChangeText = shouldChangeText
    }
}
extension CD_TextDelegate: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textFieldShouldChangeCharacters?(textField,range,string) ?? true
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEditing?(textField, .editingDidEnd)
    }
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldEditing?(textField, .editingDidBegin)
    }
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return textFieldShouldClear?(textField) ?? true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textFieldShouldReturn?(textField) ?? true
    }
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
}
extension CD_TextDelegate: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        textViewEditing?(textView, .editingChanged)
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        textViewEditing?(textView, .editingDidEnd)
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textViewEditing?(textView, .editingDidBegin)
    }
    public func textViewDidChangeSelection(_ textView: UITextView) {
        
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textViewShouldChangeText?(textView, range, text) ?? true
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return true
    }
    
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}

protocol CDTextInputTraitsProtocol:UITextInputTraits {
    //func inputTraits()
    
    /*
    optional public var autocapitalizationType: UITextAutocapitalizationType { get set } // default is UITextAutocapitalizationTypeSentences
    
    optional public var autocorrectionType: UITextAutocorrectionType { get set } // default is UITextAutocorrectionTypeDefault
    
    @available(iOS 5.0, *)
    optional public var spellCheckingType: UITextSpellCheckingType { get set } // default is UITextSpellCheckingTypeDefault;
    
    @available(iOS 11.0, *)
    optional public var smartQuotesType: UITextSmartQuotesType { get set } // default is UITextSmartQuotesTypeDefault;
    
    @available(iOS 11.0, *)
    optional public var smartDashesType: UITextSmartDashesType { get set } // default is UITextSmartDashesTypeDefault;
    
    @available(iOS 11.0, *)
    optional public var smartInsertDeleteType: UITextSmartInsertDeleteType { get set } // default is UITextSmartInsertDeleteTypeDefault;
    
    optional public var keyboardType: UIKeyboardType { get set } // default is UIKeyboardTypeDefault
    
    optional public var keyboardAppearance: UIKeyboardAppearance { get set } // default is UIKeyboardAppearanceDefault
    
    optional public var returnKeyType: UIReturnKeyType { get set } // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
    
    optional public var enablesReturnKeyAutomatically: Bool { get set } // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
    
    optional public var isSecureTextEntry: Bool { get set } // default is NO
    
    
    // The textContentType property is to provide the keyboard with extra information about the semantic intent of the text document.
    @available(iOS 10.0, *)
    optional public var textContentType: UITextContentType! { get set } // default is nil
    
    
    // The passwordRules property is used to communicate requirements for passwords for your service
    // to ensure iOS can generate compatible passwords for users. It only works when secureTextEntry
    // is YES. You do not need to use this property if the passwords that iOS generates are already
    // compatible with your service. You can learn more about the purpose of and syntax for these rules
    // on the Password Rules documentation guide.
    @available(iOS 12.0, *)
    @NSCopying optional public var passwordRules: UITextInputPasswordRules? { get set } // default is nil*/
}
