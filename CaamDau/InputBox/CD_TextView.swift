//Created  on 2019/7/18 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

//@IBDesignable
public class CD_TextView: UIView {
    convenience public init() {
        self.init(frame: .zero)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    
    
    @IBInspectable open var placeholder:String = "" {
        didSet{
            placeholderView.cd.text(placeholder)
        }
    }
    @IBInspectable open var placeColor:UIColor = UIColor.cd_hex("C7C7CC") {
        didSet{
            placeholderView.cd.text(placeColor)
        }
    }
    
    @IBInspectable open var placeholderAttributed:NSAttributedString? {
        didSet {
            placeholderView.cd.text(placeholderAttributed)
        }
    }
    var _text:String = "" {
        didSet{
            textView.cd.text(_text)
        }
    }
    @IBInspectable open var text:String {
        set{
            _text = newValue
        }
        get{
            return textView.text ?? _text
        }
    }
    
    var _textAttributed:NSAttributedString = NSAttributedString(string: "") {
        didSet{
            textView.cd.text(_textAttributed)
        }
    }
    @IBInspectable open var textAttributed:NSAttributedString {
        set{
            _textAttributed = newValue
        }
        get{
            return textView.attributedText
        }
    }
    
    var _textColor:UIColor = UIColor.black {
        didSet{
            textView.cd.text(_textColor)
        }
    }
    @IBInspectable open var textColor:UIColor {
        set{
            _textColor = newValue
        }
        get{
            return textView.textColor ?? _textColor
        }
    }
    var _tintColor:UIColor = UIColor.blue {
        didSet{
            textView.cd.tint(_tintColor)
        }
    }
    public override var tintColor: UIColor! {
        set{
            _tintColor = newValue
        }
        get{
            return textView.tintColor
        }
    }
    
    var _font:UIFont = UIFont.systemFont(ofSize: 14) {
        didSet{
            placeholderView.cd.text(_font)
            textView.cd.text(_font)
        }
    }
    @IBInspectable open var font:UIFont {
        set{
            _font = newValue
        }
        get{
            return textView.font ?? _font
        }
    }
    
    var _textContainerInset = UIEdgeInsets(t: 8, l: 5, b: 8, r: 5) {
        didSet{
            placeholderView.cd.text(containerInset: _textContainerInset)
            textView.cd.text(containerInset: _textContainerInset)
        }
    }
    @IBInspectable open var textContainerInset:UIEdgeInsets {
        set{
            _textContainerInset = newValue
        }
        get{
            return textView.textContainerInset
        }
    }
    
    
    var _textAlignment:NSTextAlignment = .left {
        didSet{
            placeholderView.cd.text(_textAlignment)
            textView.cd.text(_textAlignment)
        }
    }
    @IBInspectable open var textAlignment:NSTextAlignment {
        set{
            _textAlignment = newValue
        }
        get{
            return textView.textAlignment
        }
    }
    
    var _keyboardType:UIKeyboardType = .default {
        didSet{
            textView.cd.keyboardType(_keyboardType)
        }
    }
    @IBInspectable open var keyboardType:UIKeyboardType {
        set{
            _keyboardType = newValue
        }
        get{
            return textView.keyboardType
        }
    }
    var _returnKeyType:UIReturnKeyType = .default {
        didSet{
            textView.cd.returnKeyType(_returnKeyType)
        }
    }
    @IBInspectable open var returnKeyType:UIReturnKeyType {
        set{
            _returnKeyType = newValue
        }
        get{
            return textView.returnKeyType
        }
    }
    
    lazy var placeholderView: UITextView = {
        return UITextView(frame: self.bounds).cd
            .text(placeColor)
            .text(placeholder)
            .isUser(false)
            .build
    }()
    
    open lazy var textView: UITextView = {
        return UITextView(frame: self.bounds).cd
            .background(UIColor.clear)
            .delegate(self)
            .build
    }()
    
    open var blockEditing:((_ text: UITextView, _ event:UIControl.Event)->Void)?
    open var blockShouldChangeText:((_ text: UITextView, _ range: NSRange, _ string: String) -> Bool)?
    
    //@available(iOS 10.0, *)
    //open var interact:Interact?
    open var interact:Any?
    var observes:[NSObjectProtocol] = []
}

extension CD_TextView {
    @available(iOS 10.0, *)
    public struct Interact {
        public var blockShouldInteractTextAttachment:((_ text: UITextView, _ attachment:NSTextAttachment, _ range: NSRange, _ interaction: UITextItemInteraction) -> Bool)?
        public var blockShouldInteractURL:((_ text: UITextView, _ url:URL, _ range: NSRange, _ interaction: UITextItemInteraction) -> Bool)?
    }
}


extension CD_TextView {
    func makeUI() {
        self.cd
            .add(placeholderView)
            .add(textView)
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        placeholderView.snp.makeConstraints { (make) in
            make.edges.equalTo(textView)
        }
        
        
        if #available(iOS 10.0, *) {
            interact = Interact()
        } else {
            
        }
        
        observes.append(textView.observe(\.text, options: [.new, .old], changeHandler: { [weak self](tab, change) in
            guard let tt = self?.textView.text else{return}
            self?.placeholderView.cd.isHidden(!tt.isEmpty)
        }))
    }
}

extension CD_TextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        placeholderView.cd.isHidden(!textView.text!.isEmpty)
        blockEditing?(textView, .editingChanged)
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        blockEditing?(textView, .editingDidBegin)
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        blockEditing?(textView, .editingDidEnd)
    }
    
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard let interact = interact as? Interact else {
            return true
        }
        return interact.blockShouldInteractTextAttachment?(textView, textAttachment, characterRange, interaction) ?? true
    }
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard let interact = interact as? Interact else {
            return true
        }
        return interact.blockShouldInteractURL?(textView, URL, characterRange, interaction) ?? true
    }
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return blockShouldChangeText?(textView, range, text) ?? true
    }
}





//MARK:--- UITextView ----------
public extension CaamDau where Base: CD_TextView {
    
    @discardableResult
    func delegate(_ d:UITextViewDelegate? = nil) -> CaamDau {
        base.textView.delegate = d
        return self
    }
    
    @discardableResult
    func allows(editingTextAttributes b:Bool) -> CaamDau {
        base.textView.allowsEditingTextAttributes = b
        return self
    }
    @discardableResult
    func typing(attributes b:[NSAttributedString.Key : Any]) -> CaamDau {
        base.textView.typingAttributes = b
        return self
    }
    
    @discardableResult
    func isEditable(_ e: Bool) -> CaamDau {
        base.textView.isEditable = e
        return self
    }
    
    @discardableResult
    func isSelectable(_ s: Bool) -> CaamDau {
        base.textView.isSelectable = s
        return self
    }
    
    @discardableResult
    func text(containerInset c: UIEdgeInsets) -> CaamDau {
        base.textContainerInset = c
        return self
    }
    
    @discardableResult
    func data(detectorTypes d: UIDataDetectorTypes) -> CaamDau {
        base.textView.dataDetectorTypes = d
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
