//Created  on 2018/12/5  by LCD :https://github.com/liucaide .

import Foundation
import MJRefresh

//MARK:----------- 顶部下拉刷新
public extension CD where Base: UIScrollView {
    func headerAddMJRefresh( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshNormalHeader?)->Void)? = nil) -> CD{
        var mj = MJRefreshNormalHeader(refreshingBlock: block)
        custom?(mj)
        base.mj_header = mj
        return self
    }
    func headerAddMJRefreshGif( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshGifHeader?)->Void)? = nil) -> CD{
        var mj = MJRefreshGifHeader(refreshingBlock: block)
        custom?(mj)
        base.mj_header = mj
        return self
    }
    func footerAddMJRefresh_Back( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshBackNormalFooter?)->Void)? = nil) -> CD{
        var mj = MJRefreshBackNormalFooter(refreshingBlock: block)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    func footerAddMJRefresh_Auto( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshAutoNormalFooter?)->Void)? = nil) -> CD{
        var mj = MJRefreshAutoNormalFooter(refreshingBlock: block)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    func footerAddMJRefreshGif_Back( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshBackGifFooter?)->Void)? = nil) -> CD{
        var mj = MJRefreshBackGifFooter(refreshingBlock: block)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    func footerAddMJRefreshGif_Auto( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshAutoGifFooter?)->Void)? = nil) -> CD{
        var mj = MJRefreshAutoGifFooter(refreshingBlock: block)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    
    enum MJRefreshType {
        case beginHead
        case beginFoot
        case end
        case endNoMoreData
        case resetNoMoreData
        case hidden(_ b:Bool)
    }
    func mjRefreshType(_ ty:MJRefreshType...) -> CD {
        for item in ty {
            switch item {
            case .beginHead:
                base.mj_header?.beginRefreshing()
            case .beginFoot:
                base.mj_footer?.beginRefreshing()
            case .end:
                base.mj_header?.endRefreshing()
                base.mj_footer?.endRefreshing()
            case .endNoMoreData:
                base.mj_footer.endRefreshingWithNoMoreData()
            case .resetNoMoreData:
                base.mj_footer.resetNoMoreData()
            case .hidden(let b):
                base.mj_footer.isHidden = b
            }
        }
        return self
    }
}

public extension CD where Base: MJRefreshNormalHeader {
    var activityStyle:UIActivityIndicatorView.Style {
        set{
            base.activityIndicatorViewStyle = newValue
        }
        get{
            return base.activityIndicatorViewStyle
        }
    }
    func activityStyle(_ t:UIActivityIndicatorView.Style) -> CD{
        base.activityIndicatorViewStyle = t
        return self
    }
    enum TitlesEnum {
        case idle(_ t:String)
        case pulling(_ t:String)
        case refreshing(_ t:String)
        case willRefresh(_ t:String)
        case noMoreData(_ t:String)
    }
    /// 设置文字
    func setTitle(_ title:TitlesEnum...) -> CD {
        for item in title {
            switch item {
            case .idle(let t):
                base.setTitle(t, for: .idle)
            case .pulling(let t):
                base.setTitle(t, for: .pulling)
            case .refreshing(let t):
                base.setTitle(t, for: .refreshing)
            case .willRefresh(let t):
                base.setTitle(t, for: .willRefresh)
            case .noMoreData(let t):
                base.setTitle(t, for: .noMoreData)
            }
        }
        return self
    }
}

extension UIScrollView {
    func test(){
        self.cd.headerAddMJRefresh({
            
        }, custom: customHeader)
    }
    
    func customHeader(mj:MJRefreshNormalHeader?) -> Void {
        mj?.cd
            .activityStyle(.whiteLarge)
            .setTitle(.idle(""), .pulling(""))
    }
}
