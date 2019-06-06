
//更多代码自动化可了解 :https://github.com/liucaide/CD/tree/master/PyToSwift .

import Foundation
import UIKit
import CD

public enum CD_IconFont {
    class Help {}
    
    case tcheck(_ size:CGFloat)
    case tclose(_ size:CGFloat)
    case temoji(_ size:CGFloat)
    case tfavor_fill(_ size:CGFloat)
    case tfavor(_ size:CGFloat)
    case tloading(_ size:CGFloat)
    case tlocation_fill(_ size:CGFloat)
    case tlocation(_ size:CGFloat)
    case tround_check_fill(_ size:CGFloat)
    case tround_check(_ size:CGFloat)
    case tround_close_fill(_ size:CGFloat)
    case tround_close(_ size:CGFloat)
    case tround_right_fill(_ size:CGFloat)
    case tround_right(_ size:CGFloat)
    case tsearch(_ size:CGFloat)
    case ttime_fill(_ size:CGFloat)
    case ttime(_ size:CGFloat)
    case tunfold(_ size:CGFloat)
    case twarn_fill(_ size:CGFloat)
    case twarn(_ size:CGFloat)
    case tcamera_fill(_ size:CGFloat)
    case tcamera(_ size:CGFloat)
    case tcomment_fill(_ size:CGFloat)
    case tcomment(_ size:CGFloat)
    case tback(_ size:CGFloat)
    case tcascades(_ size:CGFloat)
    case tlist(_ size:CGFloat)
    case tmore(_ size:CGFloat)
    case tscan(_ size:CGFloat)
    case tsettings(_ size:CGFloat)
    case tpic(_ size:CGFloat)
    case ttop(_ size:CGFloat)
    case tpull_down(_ size:CGFloat)
    case tpull_up(_ size:CGFloat)
    case tright(_ size:CGFloat)
    case trefresh(_ size:CGFloat)
    case tmore_android(_ size:CGFloat)
    case tdelete_fill(_ size:CGFloat)
    case tcart(_ size:CGFloat)
    case tdelete(_ size:CGFloat)
    case thome(_ size:CGFloat)
    case tcart_fill(_ size:CGFloat)
    case thome_fill(_ size:CGFloat)
    case tmessage(_ size:CGFloat)
    case tlock(_ size:CGFloat)
    case tunlock(_ size:CGFloat)
    case tsquare_check_fill(_ size:CGFloat)
    case tsquare(_ size:CGFloat)
    case tsquare_check(_ size:CGFloat)
    case tround(_ size:CGFloat)
    case tadd(_ size:CGFloat)
    case tfold(_ size:CGFloat)
    case tinfo_fill(_ size:CGFloat)
    case tinfo(_ size:CGFloat)
    case tshare(_ size:CGFloat)
    case tsearch_list(_ size:CGFloat)
    case tsort(_ size:CGFloat)
    case tdown(_ size:CGFloat)
    case tmobile(_ size:CGFloat)
    case tmobile_fill(_ size:CGFloat)
    case tcountdown_fill(_ size:CGFloat)
    case tcountdown(_ size:CGFloat)
    case tkeyboard(_ size:CGFloat)
    case tpull_left(_ size:CGFloat)
    case tpull_right(_ size:CGFloat)
    case tpic_fill(_ size:CGFloat)
    case trefresh_arrow(_ size:CGFloat)
    case tattention_fill(_ size:CGFloat)
    case tattention(_ size:CGFloat)
    case ttag_fill(_ size:CGFloat)
    case ttag(_ size:CGFloat)
    case tradio_box(_ size:CGFloat)
    case tupload(_ size:CGFloat)
    case tradio_box_fill(_ size:CGFloat)
    case tmove(_ size:CGFloat)
    case tmessage_fill(_ size:CGFloat)
    case tmy(_ size:CGFloat)
    case tmy_fill(_ size:CGFloat)
    case ttriangle_down_fill(_ size:CGFloat)
    case ttriangle_up_fill(_ size:CGFloat)
    case tload_diamond(_ size:CGFloat)
    case temoji_light(_ size:CGFloat)
    case tkeyboard_light(_ size:CGFloat)
    case tsort_light(_ size:CGFloat)
    case tattention_forbid(_ size:CGFloat)
    case tattention_forbid_fill(_ size:CGFloat)
    case tpic_light(_ size:CGFloat)
    case tload_brush(_ size:CGFloat)
    case tusefull_fill(_ size:CGFloat)
    case tusefull(_ size:CGFloat)
    case thome_light(_ size:CGFloat)
    case tmy_light(_ size:CGFloat)
    case tcart_light(_ size:CGFloat)
    case thome_fill_light(_ size:CGFloat)
    case tcart_fill_light(_ size:CGFloat)
    case tmy_fill_light(_ size:CGFloat)
    case tsearch_light(_ size:CGFloat)
    case tscan_light(_ size:CGFloat)
    case tmessage_light(_ size:CGFloat)
    case tclose_light(_ size:CGFloat)
    case tcamera_light(_ size:CGFloat)
    case trefresh_light(_ size:CGFloat)
    case tback_light(_ size:CGFloat)
    case tshare_light(_ size:CGFloat)
    case tcomment_light(_ size:CGFloat)
    case tfavor_light(_ size:CGFloat)
    case tcomment_fill_light(_ size:CGFloat)
    case tmore_android_light(_ size:CGFloat)
    case tmore_light(_ size:CGFloat)
    case tmessage_fill_light(_ size:CGFloat)
    case tsearch_list_light(_ size:CGFloat)
    case tfavor_fill_light(_ size:CGFloat)
    case tdelete_light(_ size:CGFloat)
    case tback_android(_ size:CGFloat)
    case tback_android_light(_ size:CGFloat)
    case tdown_light(_ size:CGFloat)
    case tround_close_light(_ size:CGFloat)
    case tround_close_fill_light(_ size:CGFloat)
    case tlocation_light(_ size:CGFloat)
    case tsettings_light(_ size:CGFloat)
    case tload_eyes(_ size:CGFloat)
    case twarn_light(_ size:CGFloat)
}

extension CD_IconFont:CD_IconFontProtocol{
    public var font:UIFont {
        return UIFont.iconFont(name: "cd_iconfont", size: self.size, forClass: CD_IconFont.Help.self, from: "IconFont")
    }
    
    public var size: CGFloat {
        switch self {
        case .tcheck(let size),
             .tclose(let size),
             .temoji(let size),
             .tfavor_fill(let size),
             .tfavor(let size),
             .tloading(let size),
             .tlocation_fill(let size),
             .tlocation(let size),
             .tround_check_fill(let size),
             .tround_check(let size),
             .tround_close_fill(let size),
             .tround_close(let size),
             .tround_right_fill(let size),
             .tround_right(let size),
             .tsearch(let size),
             .ttime_fill(let size),
             .ttime(let size),
             .tunfold(let size),
             .twarn_fill(let size),
             .twarn(let size),
             .tcamera_fill(let size),
             .tcamera(let size),
             .tcomment_fill(let size),
             .tcomment(let size),
             .tback(let size),
             .tcascades(let size),
             .tlist(let size),
             .tmore(let size),
             .tscan(let size),
             .tsettings(let size),
             .tpic(let size),
             .ttop(let size),
             .tpull_down(let size),
             .tpull_up(let size),
             .tright(let size),
             .trefresh(let size),
             .tmore_android(let size),
             .tdelete_fill(let size),
             .tcart(let size),
             .tdelete(let size),
             .thome(let size),
             .tcart_fill(let size),
             .thome_fill(let size),
             .tmessage(let size),
             .tlock(let size),
             .tunlock(let size),
             .tsquare_check_fill(let size),
             .tsquare(let size),
             .tsquare_check(let size),
             .tround(let size),
             .tadd(let size),
             .tfold(let size),
             .tinfo_fill(let size),
             .tinfo(let size),
             .tshare(let size),
             .tsearch_list(let size),
             .tsort(let size),
             .tdown(let size),
             .tmobile(let size),
             .tmobile_fill(let size),
             .tcountdown_fill(let size),
             .tcountdown(let size),
             .tkeyboard(let size),
             .tpull_left(let size),
             .tpull_right(let size),
             .tpic_fill(let size),
             .trefresh_arrow(let size),
             .tattention_fill(let size),
             .tattention(let size),
             .ttag_fill(let size),
             .ttag(let size),
             .tradio_box(let size),
             .tupload(let size),
             .tradio_box_fill(let size),
             .tmove(let size),
             .tmessage_fill(let size),
             .tmy(let size),
             .tmy_fill(let size),
             .ttriangle_down_fill(let size),
             .ttriangle_up_fill(let size),
             .tload_diamond(let size),
             .temoji_light(let size),
             .tkeyboard_light(let size),
             .tsort_light(let size),
             .tattention_forbid(let size),
             .tattention_forbid_fill(let size),
             .tpic_light(let size),
             .tload_brush(let size),
             .tusefull_fill(let size),
             .tusefull(let size),
             .thome_light(let size),
             .tmy_light(let size),
             .tcart_light(let size),
             .thome_fill_light(let size),
             .tcart_fill_light(let size),
             .tmy_fill_light(let size),
             .tsearch_light(let size),
             .tscan_light(let size),
             .tmessage_light(let size),
             .tclose_light(let size),
             .tcamera_light(let size),
             .trefresh_light(let size),
             .tback_light(let size),
             .tshare_light(let size),
             .tcomment_light(let size),
             .tfavor_light(let size),
             .tcomment_fill_light(let size),
             .tmore_android_light(let size),
             .tmore_light(let size),
             .tmessage_fill_light(let size),
             .tsearch_list_light(let size),
             .tfavor_fill_light(let size),
             .tdelete_light(let size),
             .tback_android(let size),
             .tback_android_light(let size),
             .tdown_light(let size),
             .tround_close_light(let size),
             .tround_close_fill_light(let size),
             .tlocation_light(let size),
             .tsettings_light(let size),
             .tload_eyes(let size),
             .twarn_light(let size):
            return size
        }
    }
    
    public var text: String {
        switch self {
        case .tcheck:
            return ""
        case .tclose:
            return ""
        case .temoji:
            return ""
        case .tfavor_fill:
            return ""
        case .tfavor:
            return ""
        case .tloading:
            return ""
        case .tlocation_fill:
            return ""
        case .tlocation:
            return ""
        case .tround_check_fill:
            return ""
        case .tround_check:
            return ""
        case .tround_close_fill:
            return ""
        case .tround_close:
            return ""
        case .tround_right_fill:
            return ""
        case .tround_right:
            return ""
        case .tsearch:
            return ""
        case .ttime_fill:
            return ""
        case .ttime:
            return ""
        case .tunfold:
            return ""
        case .twarn_fill:
            return ""
        case .twarn:
            return ""
        case .tcamera_fill:
            return ""
        case .tcamera:
            return ""
        case .tcomment_fill:
            return ""
        case .tcomment:
            return ""
        case .tback:
            return ""
        case .tcascades:
            return ""
        case .tlist:
            return ""
        case .tmore:
            return ""
        case .tscan:
            return ""
        case .tsettings:
            return ""
        case .tpic:
            return ""
        case .ttop:
            return ""
        case .tpull_down:
            return ""
        case .tpull_up:
            return ""
        case .tright:
            return ""
        case .trefresh:
            return ""
        case .tmore_android:
            return ""
        case .tdelete_fill:
            return ""
        case .tcart:
            return ""
        case .tdelete:
            return ""
        case .thome:
            return ""
        case .tcart_fill:
            return ""
        case .thome_fill:
            return ""
        case .tmessage:
            return ""
        case .tlock:
            return ""
        case .tunlock:
            return ""
        case .tsquare_check_fill:
            return ""
        case .tsquare:
            return ""
        case .tsquare_check:
            return ""
        case .tround:
            return ""
        case .tadd:
            return ""
        case .tfold:
            return ""
        case .tinfo_fill:
            return ""
        case .tinfo:
            return ""
        case .tshare:
            return ""
        case .tsearch_list:
            return ""
        case .tsort:
            return ""
        case .tdown:
            return ""
        case .tmobile:
            return ""
        case .tmobile_fill:
            return ""
        case .tcountdown_fill:
            return ""
        case .tcountdown:
            return ""
        case .tkeyboard:
            return ""
        case .tpull_left:
            return ""
        case .tpull_right:
            return ""
        case .tpic_fill:
            return ""
        case .trefresh_arrow:
            return ""
        case .tattention_fill:
            return ""
        case .tattention:
            return ""
        case .ttag_fill:
            return ""
        case .ttag:
            return ""
        case .tradio_box:
            return ""
        case .tupload:
            return ""
        case .tradio_box_fill:
            return ""
        case .tmove:
            return ""
        case .tmessage_fill:
            return ""
        case .tmy:
            return ""
        case .tmy_fill:
            return ""
        case .ttriangle_down_fill:
            return ""
        case .ttriangle_up_fill:
            return ""
        case .tload_diamond:
            return ""
        case .temoji_light:
            return ""
        case .tkeyboard_light:
            return ""
        case .tsort_light:
            return ""
        case .tattention_forbid:
            return ""
        case .tattention_forbid_fill:
            return ""
        case .tpic_light:
            return ""
        case .tload_brush:
            return ""
        case .tusefull_fill:
            return ""
        case .tusefull:
            return ""
        case .thome_light:
            return ""
        case .tmy_light:
            return ""
        case .tcart_light:
            return ""
        case .thome_fill_light:
            return ""
        case .tcart_fill_light:
            return ""
        case .tmy_fill_light:
            return ""
        case .tsearch_light:
            return ""
        case .tscan_light:
            return ""
        case .tmessage_light:
            return ""
        case .tclose_light:
            return ""
        case .tcamera_light:
            return ""
        case .trefresh_light:
            return ""
        case .tback_light:
            return ""
        case .tshare_light:
            return ""
        case .tcomment_light:
            return ""
        case .tfavor_light:
            return ""
        case .tcomment_fill_light:
            return ""
        case .tmore_android_light:
            return ""
        case .tmore_light:
            return ""
        case .tmessage_fill_light:
            return ""
        case .tsearch_list_light:
            return ""
        case .tfavor_fill_light:
            return ""
        case .tdelete_light:
            return ""
        case .tback_android:
            return ""
        case .tback_android_light:
            return ""
        case .tdown_light:
            return ""
        case .tround_close_light:
            return ""
        case .tround_close_fill_light:
            return ""
        case .tlocation_light:
            return ""
        case .tsettings_light:
            return ""
        case .tload_eyes:
            return ""
        case .twarn_light:
            return ""
        }
    }
}


