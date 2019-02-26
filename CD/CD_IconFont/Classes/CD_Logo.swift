
    import Foundation
    import UIKit
    
    
    public enum CD_Logo {
        class Help {}
    
        case tQQ(_ size:CGFloat)
        case t朋友圈(_ size:CGFloat)
        case t朋友圈_2(_ size:CGFloat)
        case t微信(_ size:CGFloat)
        case talibabacloud(_ size:CGFloat)
        case tIE(_ size:CGFloat)
        case tamazon(_ size:CGFloat)
        case talipay(_ size:CGFloat)
        case ttaobao(_ size:CGFloat)
        case tzhihu(_ size:CGFloat)
        case tHTML5(_ size:CGFloat)
        case tapple(_ size:CGFloat)
        case tandroid(_ size:CGFloat)
        case tdingtalk(_ size:CGFloat)
        case tandroid_fill(_ size:CGFloat)
        case tapple_fill(_ size:CGFloat)
        case tHTML5_fill(_ size:CGFloat)
        case tQQ_17(_ size:CGFloat)
        case tweibo(_ size:CGFloat)
        case twechat_fill(_ size:CGFloat)
        case talipay_circle_fill(_ size:CGFloat)
        case tamazon_circle_fill(_ size:CGFloat)
        case tgithub_fill(_ size:CGFloat)
        case tQQ_circle_fill(_ size:CGFloat)
        case tIE_circle_fill(_ size:CGFloat)
        case tdingtalk_circle_fill(_ size:CGFloat)
        case ttaobao_circle_fill(_ size:CGFloat)
        case tweibo_circle_fill(_ size:CGFloat)
        case tzhihu_circle_fill(_ size:CGFloat)
        case talipay_square_fill(_ size:CGFloat)
        case tdingtalk_square_fill(_ size:CGFloat)
        case tamazon_square_fill(_ size:CGFloat)
        case tIE_square_fill(_ size:CGFloat)
        case tQQ_square_fill(_ size:CGFloat)
        case ttaobao_square_fill(_ size:CGFloat)
        case tweibo_square_fill(_ size:CGFloat)
        case tzhihu_square_fill(_ size:CGFloat)
    }
    
    extension CD_Logo:CD_IconFontProtocol{
        public var font:UIFont {
            return UIFont.iconFont(name: "cd_logo", size: self.size, forClass: CD_Logo.Help.self, from: "IconFont")
        }
        
        public var size: CGFloat {
            switch self {
            case .tQQ(let size),
            .t朋友圈(let size),
            .t朋友圈_2(let size),
            .t微信(let size),
            .talibabacloud(let size),
            .tIE(let size),
            .tamazon(let size),
            .talipay(let size),
            .ttaobao(let size),
            .tzhihu(let size),
            .tHTML5(let size),
            .tapple(let size),
            .tandroid(let size),
            .tdingtalk(let size),
            .tandroid_fill(let size),
            .tapple_fill(let size),
            .tHTML5_fill(let size),
            .tQQ_17(let size),
            .tweibo(let size),
            .twechat_fill(let size),
            .talipay_circle_fill(let size),
            .tamazon_circle_fill(let size),
            .tgithub_fill(let size),
            .tQQ_circle_fill(let size),
            .tIE_circle_fill(let size),
            .tdingtalk_circle_fill(let size),
            .ttaobao_circle_fill(let size),
            .tweibo_circle_fill(let size),
            .tzhihu_circle_fill(let size),
            .talipay_square_fill(let size),
            .tdingtalk_square_fill(let size),
            .tamazon_square_fill(let size),
            .tIE_square_fill(let size),
            .tQQ_square_fill(let size),
            .ttaobao_square_fill(let size),
            .tweibo_square_fill(let size),
            .tzhihu_square_fill(let size):
                return size
            }
        }
                    
        public var text: String {
            switch self { 
            case .tQQ:
                return ""  
            case .t朋友圈:
                return ""  
            case .t朋友圈_2:
                return ""  
            case .t微信:
                return ""  
            case .talibabacloud:
                return ""  
            case .tIE:
                return ""  
            case .tamazon:
                return ""  
            case .talipay:
                return ""  
            case .ttaobao:
                return ""  
            case .tzhihu:
                return ""  
            case .tHTML5:
                return ""  
            case .tapple:
                return ""  
            case .tandroid:
                return ""  
            case .tdingtalk:
                return ""  
            case .tandroid_fill:
                return ""  
            case .tapple_fill:
                return ""  
            case .tHTML5_fill:
                return ""  
            case .tQQ_17:
                return ""  
            case .tweibo:
                return ""  
            case .twechat_fill:
                return ""  
            case .talipay_circle_fill:
                return ""  
            case .tamazon_circle_fill:
                return ""  
            case .tgithub_fill:
                return ""  
            case .tQQ_circle_fill:
                return ""  
            case .tIE_circle_fill:
                return ""  
            case .tdingtalk_circle_fill:
                return ""  
            case .ttaobao_circle_fill:
                return ""  
            case .tweibo_circle_fill:
                return ""  
            case .tzhihu_circle_fill:
                return ""  
            case .talipay_square_fill:
                return ""  
            case .tdingtalk_square_fill:
                return ""  
            case .tamazon_square_fill:
                return ""  
            case .tIE_square_fill:
                return ""  
            case .tQQ_square_fill:
                return ""  
            case .ttaobao_square_fill:
                return ""  
            case .tweibo_square_fill:
                return ""  
            case .tzhihu_square_fill:
                return "" 
            }
        }
    }
    
