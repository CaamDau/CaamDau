//Created  on 2019/3/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import CD
import Config
import Assets

extension VM_MineTableView {
    class Model {
        var id:String!
        var img:UIImage!
        var time:TimeInterval!
        var second:Double!
        var num:Int!
        var open:Bool!
        
        var down:CD_CountDown.Model?
        
        init(_ id:String, _ img:UIImage, _ time:TimeInterval, _ second:Double, _ num:Int, _ open:Bool) {
            self.id = id
            self.img = img
            self.time = time
            self.second = second
            self.num = num
            self.open = open
            
            
        }
        
        
        
        deinit {
            CD_CountDown.shared.timers.removeValue(forKey: self.id)
        }
    }
}


class VM_MineTableView {
    enum Section:Int {
        case countdown = 0
        case end
    }
    lazy var forms:[[CD_RowProtocol]] = {
        return (0..<Section.end.rawValue).map{_ in []}
    }()
    
    var blockRequest:(()->Void)?
    
    lazy var assets:Assets = {
        return Assets()
    }()
    
    var refreshTypes:[CD_MJRefreshModel.RefreshType] = {
        return [.tHiddenFoot(true),
                .tBegin]
    }()
    lazy var modelMj:CD_MJRefreshModel = {
        var m = CD_MJRefreshModel()
        let ass = Assets()
        let arr = [ass.refresh_0,
                   ass.refresh_1,
                   ass.refresh_2,
                   ass.refresh_3,
                   ass.refresh_4,
                   ass.refresh_5,
                   ass.refresh_6,
                   ass.refresh_7]
        m.down_imgIdle = [UIImage.cd_iconfont(CD_IconFont.temoji(60), color:Config.color.txt_5, point: UIImage.CD_IconFontMode.center.point(CD_IconFont.temoji(60).size))]
        
        m.down_imgPulling = [UIImage.cd_iconfont(CD_IconFont.tpull_up(60), color:Config.color.txt_5, point: UIImage.CD_IconFontMode.center.point(CD_IconFont.tpull_up(60).size))]
        
        m.down_imgWillRefresh = [UIImage.cd_iconfont(CD_IconFont.trefresh(60), color:Config.color.txt_5, point: UIImage.CD_IconFontMode.center.point(CD_IconFont.trefresh(60).size))]
        
        m.down_imgRefreshing = arr
        return m
    }()
    
    init() {
        
    }
    
    func requestData(_ refresh:Bool) {
        self.refreshTypes = [.tHiddenFoot(false),
                             .tEnd]
        if refresh {
            self.refreshTypes.append(.tNoMoreDataReset)
            self.forms = (0..<Section.end.rawValue).map{_ in []}
            makeForm()
        }else{
            self.refreshTypes.append(.tNoMoreDataEnd)
        }
        
        
        CD_CountDown.after(2) {[weak self] in
            self?.blockRequest?()
        }
    }
    
    let detail = "移动开发唱衰，iOS 开发者如何涅槃重生"
    
}

//MARK:--- 排版 ----------
extension VM_MineTableView{
    func makeForm() {
        
        var models:[Model] = []
        models.append(Model("model_1", assets.logo_200, 370000, 1, 3, false))
        models.append(Model("model_2", assets.logo_0, 3700, 0.09, 4, true))
        models.append(Model("model_3", assets.logo_200, 36000, 1, 5, false))
        models.append(Model("model_4", assets.logo_0, 3700, 1, 6, false))
        models.append(Model("model_5", assets.logo_200, 3700, 1, 37, false))
        models.append(Model("model_6", assets.logo_0, 3700, 1, 38, true))
        models.append(Model("model_7", assets.logo_200, 3700, 1, 39, false))
        models.append(Model("model_8", assets.logo_0, 3700, 1, 32, false))
        models.append(Model("model_9", assets.logo_200, 3700, 1, 345, false))
        models.append(Model("model_10", assets.logo_0, 3700, 1, 378, false))
        models.append(Model("model_11", assets.logo_200, 3700, 1, 3111, false))
        models.append(Model("model_12", assets.logo_0, 3700, 1, 31, false))
        
        for (i,item) in models.enumerated() {
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:10))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{// 倒计时
                let row = CD_Row<Cell_MineCountDown>(data: item, frame: CGRect(h:100))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:10))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgF0, frame: CGRect(h:0.5))
                self.forms[Section.countdown.rawValue].append(row)
            }
            
            if i > 0 {
                do{//分割线
                    let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:5))
                    self.forms[Section.countdown.rawValue].append(row)
                }
                do{//描述
                    let row = CD_Row<Cell_MineDetail>(data: (0..<i).map{_ in detail}.joined(separator: ","), frame: CGRect(h:UITableView.automaticDimension))
                    self.forms[Section.countdown.rawValue].append(row)
                }
                do{//分割线
                    let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:5))
                    self.forms[Section.countdown.rawValue].append(row)
                }
                do{//分割线
                    let row = CD_Row<Cell_MineLine>(data: .bgF0, frame: CGRect(h:0.5))
                    self.forms[Section.countdown.rawValue].append(row)
                }
            }
            
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:5))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//输入
                let row = CD_Row<Cell_MineInput>(data: item, frame: CGRect(h:30))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:5))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgF0, frame: CGRect(h:0.5))
                self.forms[Section.countdown.rawValue].append(row)
            }
            
            
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:5))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//开关
                let row = CD_Row<Cell_MineSwitch>(data: item, frame: CGRect(h:UITableView.automaticDimension))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:5))
                self.forms[Section.countdown.rawValue].append(row)
            }
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgF0, frame: CGRect(h:8))
                self.forms[Section.countdown.rawValue].append(row)
            }
        }
    }
}
