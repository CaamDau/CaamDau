//Created  on 2019/6/6 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
class View_PageConfig: UIView {
    @IBOutlet weak var bar_alig: UISegmentedControl!
    @IBOutlet weak var bar_marge: UISlider!
    @IBOutlet weak var bar_space: UISlider!
    @IBOutlet weak var bar_itemAni: UISegmentedControl!
    @IBOutlet weak var bar_buoyAni: UISegmentedControl!
    
    @IBAction func segmentClick(_ sender: UISegmentedControl) {
        switch sender {
        case bar_alig:
            model.bar_alig = [.leftOrTop, .center, .rightOrBottom][sender.selectedSegmentIndex]
        case bar_itemAni:
            model.bar_itemAni = [.zoom, .lineZoom, .none][sender.selectedSegmentIndex]
        case bar_buoyAni:
            model.bar_buoyAni = [.slide, .crawl, .none][sender.selectedSegmentIndex]
        default:
            break
        }
    }
    @IBAction func sliderClick(_ sender: UISlider) {
        switch sender {
        case bar_marge:
            model.bar_marge = CGFloat(sender.value)
        case bar_space:
            model.bar_space = CGFloat(sender.value)
        default:
            break
        }
    }
    
    var model:View_PageConfig.Model = View_PageConfig.Model() {
        didSet{
            callBack?(model)
        }
    }
    
    @IBAction func dataClick(_ sender: UIButton) {
        callBack?(sender.tag)
    }
    
    
    
    var callBack: CD_RowCallBack?
}
extension View_PageConfig {
    struct Model {
        var bar_alig:CD_Page.Model.Alignment = .leftOrTop
        var bar_marge:CGFloat = 10
        var bar_space:CGFloat = 10
        var bar_itemAni:CD_PageControlItem.Model.Animotion = .zoom
        var bar_buoyAni:CD_PageControlBuoy.Model.Animotion = .slide
    }
}
extension View_PageConfig: CD_UIViewProtocol {
    static func row_init(withDataSource dataSource: View_PageConfig.Model?, config: Any?, callBack: CD_RowCallBack?, tapBlock: CD_RowDidSelectBlock?) -> UIView {
        let v = View_PageConfig.cd_loadNib(from:"Mine")?.first as? View_PageConfig ?? View_PageConfig()
        v.callBack = callBack
        v.model = dataSource ?? View_PageConfig.Model()
        return v
    }
    
    static func show() -> View_PageConfig {
        return View_PageConfig.cd_loadNib(from: "Mine")?.first as? View_PageConfig ?? View_PageConfig()
    }
    
    
    typealias ConfigModel = Any
    
    typealias DataSource = View_PageConfig.Model
    
    
    
}
