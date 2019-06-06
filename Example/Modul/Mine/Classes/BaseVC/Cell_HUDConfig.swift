//Created  on 2019/5/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
import Assets

extension CD_HUD.Axis {
    var intValue:Int {
        switch self {
        case .vertical: return 0
        case .horizontal: return 1
        }
    }
}
extension CD_HUD.Position {
    var intValue:Int {
        switch self {
        case .top: return 0
        case .center: return 1
        case .bottom: return 2
        case .custom: return 3
        }
    }
}
extension CD_HUD.Animation {
    var intValue:Int {
        switch self {
        case .fade: return 0
        case .slide: return 1
        case .zoom: return 2
        case .spring: return 3
        case .custom: return 4
        case .none: return 5
        }
    }
}
extension CD_HUD.Style {
    var intValue:Int {
        switch self {
        case .text: return 0
        case .loading: return 1
        case .info: return 2
        case .succeed: return 3
        case .warning: return 4
        case .error: return 5
        case .progress: return 6
        case .custom: return 7
        }
    }
}
extension CD_HUD.Style.Loading {
    var intValue:Int {
        switch self {
        case .activity: return 0
        case .ring: return 1
        case .arrow:return 2
        case .diamond:return 4
        case .brush:return 5
        case .roundEyes:return 6
        case .images:return 3
        case .view:return 7
        }
    }
}

class Cell_HUDConfig: UITableViewCell {
    @IBOutlet weak var switch_enabled: UISwitch!
    @IBOutlet weak var switch_square: UISwitch!
    @IBOutlet weak var segmented_axis: UISegmentedControl!
    @IBOutlet weak var segmented_position: UISegmentedControl!
    @IBOutlet weak var segmented_alignment: UISegmentedControl!
    @IBOutlet weak var segmented_show: UISegmentedControl!
    @IBOutlet weak var segmented_hidden: UISegmentedControl!
    @IBOutlet weak var segmented_loading: UISegmentedControl!
    @IBOutlet weak var segmented_infos: UISegmentedControl!
    @IBOutlet weak var btn_margeM: UIButton!
    @IBOutlet weak var btn_colorM: UIButton!
    @IBOutlet weak var btn_colorBg: UIButton!
    @IBOutlet weak var btn_marge: UIButton!
    @IBOutlet weak var btn_space: UIButton!
    @IBOutlet weak var btn_topY: UIButton!
    @IBOutlet weak var btn_bottomY: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switch_enabled.isOn = CD_HUD.modelDefault._isEnabledMask
        switch_square.isOn = CD_HUD.modelDefault._isSquare
        segmented_axis.selectedSegmentIndex = CD_HUD.modelDefault._axis.intValue
        segmented_position.selectedSegmentIndex = CD_HUD.modelDefault._position.intValue
        segmented_show.selectedSegmentIndex = CD_HUD.modelDefault._showAnimation.intValue == 5 ? 4 : CD_HUD.modelDefault._showAnimation.intValue
        segmented_hidden.selectedSegmentIndex = CD_HUD.modelDefault._hiddenAnimat.intValue == 5 ? 3 : CD_HUD.modelDefault._hiddenAnimat.intValue
        segmented_infos.selectedSegmentIndex = VM_HUD.infoStyle.intValue + 2
        segmented_loading.selectedSegmentIndex = VM_HUD.loadingStyle?.intValue ?? 0
        segmented_alignment.selectedSegmentIndex = CD_HUD.modelDefault._textAlignment.rawValue
        
        
        makeButton()
    }
    func makeButton(){
        btn_margeM.cd.text("margeM:\(CD_HUD.modelDefault._margeMask)")
        btn_colorM.cd.text("colorM:\(CD_HUD.modelDefault._colorMask.cd_hex)")
        btn_colorBg.cd.text("colorBg:\(CD_HUD.modelDefault._colorBg.cd_hex)")
        btn_marge.cd.text("marge:\(CD_HUD.modelDefault._marge)")
        btn_space.cd.text("space:\(CD_HUD.modelDefault._space)")
        btn_topY.cd.text("topY:\(CD_HUD.modelDefault._offsetTopY)")
        btn_bottomY.cd.text("bottomY:\(CD_HUD.modelDefault._offsetBottomY)")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchClick(_ sender: UISwitch) {
        switch sender {
        case switch_enabled:
            CD_HUD.modelDefault._isEnabledMask = sender.isOn
        case switch_square:
            CD_HUD.modelDefault._isSquare = sender.isOn
        default:
            break
        }
    }
    lazy var gif: [UIImage] = {
        let assets = Assets()
        return [assets.refresh_0,
                assets.refresh_1,
                assets.refresh_2,
                assets.refresh_3,
                assets.refresh_4,
                assets.refresh_5,
                assets.refresh_6,
                assets.refresh_7]
    }()
    
    
    @IBAction func segmentedClick(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        switch sender {
        case segmented_axis:
            CD_HUD.modelDefault._axis = [.vertical, .horizontal][idx]
        case segmented_position:
            CD_HUD.modelDefault._position = [.top,.center,.bottom][idx]
        case segmented_alignment:
            CD_HUD.modelDefault._textAlignment = [.left,.center,.right][idx]
        case segmented_show:
            CD_HUD.modelDefault._showAnimation = [.fade,.slide,.zoom, .spring, .none][idx]
        case segmented_hidden:
            CD_HUD.modelDefault._hiddenAnimat = [.fade,.slide,.zoom, .none][idx]
        case segmented_loading:
            VM_HUD.loadingStyle = [.activity,.ring,.arrow,.images(gif,0.8,0),.diamond,.brush,.roundEyes][idx]
        case segmented_infos:
            VM_HUD.infoStyle = [.info,.succeed,.warning,.error][idx]
        default:
            break
        }
    }
    
    lazy var dotView: CD_HUDCustomLoadingView = {
        return CD_HUDCustomLoadingView()
    }()
    
    @IBAction func textChange(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            VM_HUD.title = sender.text ?? ""
        default:
            VM_HUD.detail = sender.text ?? ""
        }
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender {
        case btn_margeM:
            CD_HUD.modelDefault._margeMask = [20,40,100][Int(arc4random() % 3)]
        case btn_colorM:
            CD_HUD.modelDefault._colorMask = [UIColor.red,UIColor.black,UIColor.gray][Int(arc4random() % 3)].cd_alpha([0.0,0.3,0.5][Int(arc4random() % 3)])
        case btn_colorBg:
            CD_HUD.modelDefault._colorBg = [UIColor.red,UIColor.black,UIColor.gray][Int(arc4random() % 3)].cd_alpha([0.6,0.8,1.0][Int(arc4random() % 3)])
        case btn_marge:
            CD_HUD.modelDefault._marge = [5,10,30][Int(arc4random() % 3)]
        case btn_space:
            CD_HUD.modelDefault._space = [5,10,30][Int(arc4random() % 3)]
        case btn_topY:
            CD_HUD.modelDefault._offsetTopY = [40,88,200][Int(arc4random() % 3)]
        case btn_bottomY:
            CD_HUD.modelDefault._offsetBottomY = [5,88,200][Int(arc4random() % 3)]
        default:
            break
        }
        makeButton()
    }
}

extension Cell_HUDConfig: CD_RowUpdateProtocol {
    typealias DataSource = Any
    func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        
    }
}




//MARK:--- 自定义LoadingView ----------
class CD_HUDCustomLoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    convenience init() {
        self.init(frame: CGRect( w: 50, h: 50))
    }
}
