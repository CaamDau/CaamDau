//Created  on 2019/4/26 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import SnapKit

//@IBDesignable
public class CD_TextField: UIView {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.makeUI()
    }
    convenience public init() {
        self.init(frame: CGRect.zero)
    }
    //MARK:--- Color ----------
    @IBInspectable open var _colorLine:UIColor = .lightGray {
        didSet{
            updateLineColor()
        }
    }
    @IBInspectable open var _colorPlaceholder:UIColor = .lightGray {
        didSet{
            btn_placeholder.cd.text(_colorPlaceholder, .normal)
        }
    }
    @IBInspectable open var _placeholder:String = "" {
        didSet{
            btn_placeholder.cd.text(_placeholder)
        }
    }
    @IBInspectable open var _placeholderAttributed:NSAttributedString = NSAttributedString(string: "") {
        didSet{
            btn_placeholder.cd.text(_placeholderAttributed)
        }
    }
    @IBInspectable open var _placeholderAlignment:UIControl.ContentHorizontalAlignment = .left {
        didSet{
            btn_placeholder.cd.contentAlignment(horizontal:_placeholderAlignment)
        }
    }
    
    //MARK:--- Width ----------
    @IBInspectable open var _widthBtnLeft:CGFloat = 0 {
        didSet{
            btn_left.snp.updateConstraints { (make) in
                make.width.equalTo(_widthBtnLeft)
            }
        }
    }
    @IBInspectable open var _widthBtnRight:CGFloat = 0 {
        didSet{
            btn_right.snp.updateConstraints { (make) in
                make.width.equalTo(_widthBtnRight)
            }
        }
    }
    @IBInspectable open var _widthLineLeft:CGFloat = 0 {
        didSet{
            line_left.snp.updateConstraints { (make) in
                make.width.equalTo(_widthLineLeft)
            }
        }
    }
    
    @IBInspectable open var _widthLineRight:CGFloat = 0 {
        didSet{
            line_right.snp.updateConstraints { (make) in
                make.width.equalTo(_widthLineRight)
            }
        }
    }
    
    @IBInspectable open var _heightLineTop:CGFloat = 0 {
        didSet{
            line_top.snp.updateConstraints { (make) in
                make.height.equalTo(_heightLineTop)
            }
        }
    }
    
    @IBInspectable open var _heightLineBottom:CGFloat = 0 {
        didSet{
            line_bottom.snp.updateConstraints { (make) in
                make.width.equalTo(_heightLineBottom)
            }
        }
    }
    
    @IBInspectable open var _font:UIFont = UIFont.systemFont(ofSize: 14) {
        didSet{
            btn_placeholder.cd.text(_font)
            text_field.cd.text(_font)
        }
    }
    
    open var _returnKeyType:UIReturnKeyType = .done {
        didSet{
            text_field.returnKeyType = _returnKeyType
        }
    }
    
    open lazy var btn_left: UIButton = {
        return UIButton()
    }()
    
    open lazy var btn_right: UIButton = {
        return UIButton()
    }()
    
    open lazy var btn_placeholder: UIButton = {
        return UIButton().cd
            .text(_colorPlaceholder, .normal)
            .text(_font)
            .text(UIColor.lightGray)
            .contentAlignment(horizontal: _placeholderAlignment)
            .isUser(false)
            .build
    }()
    
    open lazy var line_top: UIView = {
        return UIView().cd
            .background(_colorLine)
            .build
    }()
    
    open lazy var line_bottom: UIView = {
        return UIView().cd
            .background(_colorLine)
            .build
    }()
    
    open lazy var line_left: UIView = {
        return UIView().cd
            .background(_colorLine)
            .build
    }()
    
    open lazy var line_right: UIView = {
        return UIView().cd
            .background(_colorLine)
            .build
    }()
    
    open lazy var text_field: UITextField = {
        let text = UITextField().cd
            .delegate(self)
            .returnKeyType(.done)
            .clear(buttonMode: .whileEditing)
            .text(UIFont.systemFont(ofSize: 14))
            .build
        text.addTarget(self, action: #selector(textChange(_:)), for: UIControl.Event.editingChanged)
        return text
    }()
    
    open var blockEditing:((_ textField: UITextField, _ event:UIControl.Event)->Void)?
    open var blockShouldClear:((_ textField: UITextField) -> Bool)?
    open var blockShouldReturn:((_ textField: UITextField) -> Bool)?
    
    open var blockShouldChangeCharacters:((_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool)?
}
extension CD_TextField: UITextFieldDelegate {
    @objc func textChange(_ sender: UITextField) {
        btn_placeholder.cd.isHidden(!sender.text!.isEmpty)
        blockEditing?(sender, UIControl.Event.editingChanged)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updateLayoutPlaceholder(false)
        blockEditing?(textField, UIControl.Event.editingDidBegin)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        updateLayoutPlaceholder(true)
        blockEditing?(textField, UIControl.Event.editingDidEnd)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return blockShouldClear?(textField) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return blockShouldReturn?(textField) ?? true
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return blockShouldChangeCharacters?(textField, range, string) ?? true
    }
}

extension CD_TextField {
    func makeUI() {
        self.cd
            .add(btn_left)
            .add(btn_right)
            .add(line_top)
            .add(line_bottom)
            .add(line_left)
            .add(line_right)
            .add(text_field)
            .add(btn_placeholder)
        
        makeLayout()
    }
    
    func makeLayout() {
        btn_left.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(_widthBtnLeft)
        }
        btn_right.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(_widthBtnRight)
        }
        
        line_left.snp.makeConstraints { (make) in
            make.left.equalTo(btn_left.snp.right).offset(0)
            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(_widthLineLeft)
        }
        
        line_right.snp.makeConstraints { (make) in
            make.right.equalTo(btn_right.snp.left).offset(0)
            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(_widthLineRight)
        }
        
        line_top.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(_heightLineTop)
        }
        
        line_bottom.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(_heightLineBottom)
        }
        
        text_field.snp.makeConstraints { (make) in
            make.left.equalTo(line_left.snp.right).offset(0)
            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalTo(line_right.snp.left).offset(0)
        }
        
        btn_placeholder.snp.makeConstraints { (make) in
            make.edges.equalTo(text_field)
        }
    }
    
    
}
extension CD_TextField {
    func updateLineColor() {
        line_top.cd.background(_colorLine)
        line_bottom.cd.background(_colorLine)
        line_left.cd.background(_colorLine)
        line_right.cd.background(_colorLine)
    }
    
    func updateLayoutPlaceholder(_ recover:Bool) {
        if _placeholderAlignment != .left && !recover {
            self.setNeedsLayout()
            btn_placeholder.snp.remakeConstraints { (make) in
                make.left.top.bottom.equalTo(text_field)
            }
            UIView.animate(withDuration: 0.2) {[weak self] in
                self?.layoutIfNeeded()
            }
        }else if recover {
            self.setNeedsLayout()
            btn_placeholder.snp.remakeConstraints { (make) in
                make.edges.equalTo(text_field)
            }
            UIView.animate(withDuration: 0.2) {[weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
}

