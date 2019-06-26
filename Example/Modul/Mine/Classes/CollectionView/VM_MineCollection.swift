//Created  on 2019/3/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
import Util

extension VM_MineCollection {
    enum Section:Int {
        case value0
        case value1
        case value2
        case value3
        case value4
        case value5
        case value6
        case end
        
        var titleValue:String {
            return "阿里矢量图标 IconFont 使用"
        }
    }
}

struct VM_MineCollection {
    lazy var forms:[[CD_RowProtocol]] = {
        return (0..<Section.end.rawValue).map{_ in []}
    }()
    
    lazy var formsHeader:[CD_RowProtocol] = {
        return (0..<Section.end.rawValue).map({ (i) -> CD_RowProtocol in
            let icon = CD_IconFont.tlist(15)
            let color = i%2 == 0 ? Config.color.main_1 : Config.color.main_2
            return CD_Row<View_MineCollectionHeader>(data: (icon, color, Section(rawValue: i)!.titleValue), frame: CGRect(w: cd_screenW(), h: 30), insets: UIEdgeInsets(t: 5, l: 5, b: 5, r: 5), bundleFrom: "Mine")
        })
    }()
    
    lazy var formsFooter:[CD_RowProtocol] = {
        return (0..<Section.end.rawValue).map({ (i) -> CD_RowProtocol in
            let icon = CD_IconFont.tlist(20)
            let color = i%2 == 0 ? Config.color.main_1 : Config.color.main_2
            return CD_Row<View_MineCollectionFooter>.init(data: attributedString(i), frame: CGRect(w: cd_screenW(), h: 40), bundleFrom: "Mine")
        })
    }()
    
    lazy var registerView:[CaamDau<UICollectionView>.CD_View] = {
        return [.tCell(Cell_MineCollectionImage.self, nil, "Mine"),
                .tCell(Cell_MineCollectionLabel.self, nil, nil),
                .tView(View_MineCollectionHeader.self, nil, .tHeader, "Mine"),
                .tView(View_MineCollectionFooter.self, nil, .tFooter, "Mine")]
    }()
    
    init() {
        makeFormsValue0()
        makeFormsValue(.value1)
        makeFormsValue(.value2)
        makeFormsValue(.value3)
        makeFormsValue(.value4)
        makeFormsValue(.value5)
        makeFormsValue(.value6)
    }
}


extension VM_MineCollection {
    mutating func makeFormsValue0() {
        let ww:CGFloat = (cd_screenW()-20)/3
        let www:CGFloat = 60
        let arr:[(CD_IconFont, UIView.ContentMode)] = [
            (CD_IconFont.temoji(www), .topLeft),
            (CD_IconFont.tcamera(www), .top),
            (CD_IconFont.tscan(www), .topRight),
            (CD_IconFont.tcascades(www), .left),
            (CD_IconFont.thome(www), .center),
            (CD_IconFont.tmessage(www), .right),
            (CD_IconFont.tdelete(www), .bottomLeft),
            (CD_IconFont.twarn(www), .bottom),
            (CD_IconFont.tlocation(www), .bottomRight)]
        for item in arr {
            let row = CD_Row<Cell_MineCollectionImage>(data: (item.0,Config.color.main_2,item.1), frame: CGRect(x: 5, y: 5, w: ww, h: ww + 30), bundleFrom: "Mine")
            self.forms[Section.value0.rawValue].append(row)
        }
    }
    mutating func makeFormsValue(_ v:Section) {
        let arr:[CD_IconFont] = [CD_IconFont.temoji(60),
                                 CD_IconFont.tcamera(60),
                                 CD_IconFont.tscan(60)]
        for item in arr {
            let row = CD_Row<Cell_MineCollectionLabel>(data: (item,Config.color.txt_1), frame: CGRect(x: 5, y: 5, w: (cd_screenW()-20)/3, h: (cd_screenW()-20)/3 + 20), bundleFrom: "Mine")
            self.forms[v.rawValue].append(row)
        }
    }
}

extension VM_MineCollection {
    func attributedString(_ idx:Int) -> NSAttributedString{
        let str = NSMutableAttributedString()
        if idx > 0 {
            for _ in 0..<(idx>5 ? 5 : idx) {
                str.append(CD_IconFont.tfavor_fill(20).attributedString)
            }
        }
        if 5 - idx > 0 {
            for _ in 0..<(5 - idx) {
                str.append(CD_IconFont.tfavor(20).attributedString)
            }
        }
        return str
    }
}
