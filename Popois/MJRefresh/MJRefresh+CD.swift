//Created  on 2018/11/5  by LCD :https://github.com/liucaide .

/******* 模块文档
 * 1，CD_MJRefresh 单例 用于全局自定义刷新样式
 * 2，如果全局使用 MJRefreshHeader+CD 中 扩展样式 继可不比使用单例，节省一个单例资源
 * 1，2，即如 headerMJWithModel # headerMJ 的区别
 */




import Foundation
import UIKit
import MJRefresh

//MARK:--- MJRefresh 添加 ----------
public extension CD where Base: UIScrollView {
    //MARK:--- 下拉 ----------
    /// 添加默认下拉 - 添加自定义模型 block 回调 custom 自定义
    @discardableResult
    func headerMJWithModel(_ block:@escaping MJRefreshComponentRefreshingBlock, model:CD_MJRefreshModel = CD_MJRefresh.shared.model, custom:((MJRefreshNormalHeader?)->Void)? = nil) -> CD{
        let mj = MJRefreshNormalHeader(refreshingBlock: block)
        self.header(normal:mj, model: model)
        custom?(mj)
        base.mj_header = mj
        return self
    }
    /// 添加默认下拉 - 不添加自定义模型，使用默认，不加载CD_MJRefresh单例
    @discardableResult
    func headerMJ(_ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshNormalHeader?)->Void)? = nil) -> CD{
        let mj = MJRefreshNormalHeader(refreshingBlock: block)
        self.header(normal:mj, model: nil)
        custom?(mj)
        base.mj_header = mj
        return self
    }
    /// 添加Gif下拉
    @discardableResult
    func headerMJGifWithModel( _ block:@escaping MJRefreshComponentRefreshingBlock, model:CD_MJRefreshModel = CD_MJRefresh.shared.model, custom:((MJRefreshGifHeader?)->Void)? = nil) -> CD{
        let mj = MJRefreshGifHeader(refreshingBlock: block)
        self.headerGif(mj, model: model)
        custom?(mj)
        base.mj_header = mj
        return self
    }
    /// 添加Gif下拉 - 不添加自定义模型，使用默认，不加载CD_MJRefresh单例
    @discardableResult
    func headerMJGif( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshGifHeader?)->Void)? = nil) -> CD{
        let mj = MJRefreshGifHeader(refreshingBlock: block)
        self.headerGif(mj, model: nil)
        custom?(mj)
        base.mj_header = mj
        return self
    }
    private func header(normal mj: MJRefreshNormalHeader?, model:CD_MJRefreshModel?) {
        guard let m = model  else {
            mj?.cd.activityStyle().setTitle().setTime()
            return
        }
        mj?.cd
            .activityStyle(m.down_activityStyle)
            .ignoredContentInsetTop(m.ignoredContentInsetTop)
        self.header(mj, m: m)
    }
    
    private func header(_ mj: MJRefreshStateHeader?, m:CD_MJRefreshModel) {
        mj?.cd
            .setTitle(isHidden: m.down_txtHidden,
                      font: m.down_txtFont,
                      color: m.down_txtColor,
                      inset: m.down_leftInset,
                      title: [.idle(m.down_txtIdle),
                              .pulling(m.down_txtPulling),
                              .willRefresh(m.down_txtWillRefresh),
                              .refreshing(m.down_txtRefreshing),
                              .noMoreData(m.down_txtNoMoreData)])
            .setTime(isHidden: m.down_timeHidden,
                     font: m.down_timeFont,
                     color: m.down_timeColor,
                     timeText: { (date) -> (String) in
                        return m.down_timeText?(date) ?? ""
            })
    }
    private func headerGif(_ mj: MJRefreshGifHeader?, model:CD_MJRefreshModel?) {
        guard let m = model  else {
            mj?.cd.setTitle().setTime().setImages()
            return
        }
        self.header(mj, m: m)
        mj?.cd.setImages([.idle(m.down_imgIdle),
                          .pulling(m.down_imgPulling),
                          .willRefresh(m.down_imgWillRefresh),
                          .refreshing(m.down_imgRefreshing),
                          .noMoreData(m.down_imgNoMoreData)])
    }
    
    //MARK:--- 上拉 ----------
    /// 添加默认上拉
    @discardableResult
    func footerMJBack( _ block:@escaping MJRefreshComponentRefreshingBlock, model:CD_MJRefreshModel = CD_MJRefresh.shared.model, custom:((MJRefreshBackNormalFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshBackNormalFooter(refreshingBlock: block)
        self.footer(withBack: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加默认上拉
    @discardableResult
    func footerMJBackWithModel( _ block:@escaping MJRefreshComponentRefreshingBlock, model:CD_MJRefreshModel = CD_MJRefresh.shared.model, custom:((MJRefreshBackNormalFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshBackNormalFooter(refreshingBlock: block)
        self.footer(withBack: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加默认上拉 - 自动刷
    @discardableResult
    func footerMJAuto( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshAutoNormalFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshAutoNormalFooter(refreshingBlock: block)
        self.footer(withAuto: mj, model: nil)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加默认上拉 - 自动刷
    @discardableResult
    func footerMJAutoWithModel(_ block:@escaping MJRefreshComponentRefreshingBlock, model:CD_MJRefreshModel = CD_MJRefresh.shared.model, custom:((MJRefreshAutoNormalFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshAutoNormalFooter(refreshingBlock: block)
        self.footer(withAuto: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉
    @discardableResult
    func footerMJGifBackWithModel( _ block:@escaping MJRefreshComponentRefreshingBlock, model:CD_MJRefreshModel = CD_MJRefresh.shared.model, custom:((MJRefreshBackGifFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshBackGifFooter(refreshingBlock: block)
        self.footerGif(withBack: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉
    @discardableResult
    func footerMJGifBack( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshBackGifFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshBackGifFooter(refreshingBlock: block)
        self.footerGif(withBack: mj, model: nil)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉 - 自动刷
    @discardableResult
    func footerMJGifAutoWithModel( _ block:@escaping MJRefreshComponentRefreshingBlock, model:CD_MJRefreshModel = CD_MJRefresh.shared.model, custom:((MJRefreshAutoGifFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshAutoGifFooter(refreshingBlock: block)
        self.footerGif(withAuto: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉 - 自动刷
    @discardableResult
    func footerMJGifAuto( _ block:@escaping MJRefreshComponentRefreshingBlock, custom:((MJRefreshAutoGifFooter?)->Void)? = nil) -> CD{
        let mj = MJRefreshAutoGifFooter(refreshingBlock: block)
        self.footerGif(withAuto: mj, model: nil)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    
    private func footer(withBack mj: MJRefreshBackNormalFooter?, model:CD_MJRefreshModel?) {
        guard let m = model else {
            mj?.cd.activityStyle().setTitle()
            return
        }
        mj?.cd
            .activityStyle(m.up_activityStyle)
        self.footer(back: mj, model: m)
    }
    private func footer(withAuto mj: MJRefreshAutoNormalFooter?, model:CD_MJRefreshModel?) {
        guard let m = model else {
            mj?.cd
                .activityStyle()
                .setTitle()
            
            return
        }
        mj?.cd.activityStyle(m.up_activityStyle)
        self.footer(auto: mj, model: m)
    }
    
    private func footer(back mj: MJRefreshBackStateFooter?, model:CD_MJRefreshModel) {
        mj?.cd.setTitle(isHidden: model.up_txtHidden,
                        font: model.up_txtFont,
                        color: model.up_txtColor,
                        inset: model.up_leftInset,
                        title: [.idle(model.up_txtIdle),
                                .pulling(model.up_txtPulling),
                                .willRefresh(model.up_txtWillRefresh),
                                .refreshing(model.up_txtRefreshing),
                                .noMoreData(model.up_txtNoMoreData)])
    }
    private func footer(auto mj: MJRefreshAutoStateFooter?, model:CD_MJRefreshModel) {
        mj?.cd
            .setTitle(isHidden: model.up_txtHidden,
                        font: model.up_txtFont,
                        color: model.up_txtColor,
                        inset: model.up_leftInset,
                        title: [.idle(model.up_txtIdle),
                                .pulling(model.up_txtPulling),
                                .willRefresh(model.up_txtWillRefresh),
                                .refreshing(model.up_txtRefreshing),
                                .noMoreData(model.up_txtNoMoreData)])
            .isAutoRefresh(model.isAutoRefresh)
            .autoRefreshPercent(model.autoRefreshPercent)
            .onlyRefreshPerDrag(model.onlyRefreshPerDrag)
            .ignoredContentInsetBottom(model.ignoredContentInsetBottom)
        
    }
    private func footerGif(withBack mj: MJRefreshBackGifFooter?, model:CD_MJRefreshModel?) {
        guard let m = model else {
            mj?.cd.setTitle().setImages()
            return
        }
        self.footer(back: mj, model: m)
        mj?.cd
            .setImages([.idle(m.up_imgIdle),
                        .pulling(m.up_imgPulling),
                        .willRefresh(m.up_imgWillRefresh),
                        .refreshing(m.up_imgRefreshing),
                        .noMoreData(m.up_imgNoMoreData)])
       
    }
    private func footerGif(withAuto mj: MJRefreshAutoGifFooter?, model:CD_MJRefreshModel?) {
        guard let m = model else {
            mj?.cd.setTitle().setImages()
            return
        }
        self.footer(auto: mj, model: m)
        mj?.cd
            .setImages([.idle(m.up_imgIdle),
                        .pulling(m.up_imgPulling),
                        .willRefresh(m.up_imgWillRefresh),
                        .refreshing(m.up_imgRefreshing),
                        .noMoreData(m.up_imgNoMoreData)])
    }
    
    
    /// 设置刷新状态
    @discardableResult
    func mjRefreshTypes(_ types:[CD_MJRefreshModel.RefreshType]) -> CD {
        var types = types
        types.sort{$0.intValue < $1.intValue}
        for item in types {
            switch item {
            case .tBegin:
                self.beginRefreshing()
            case .tEnd:
                self.endRefreshing()
            case .tNoMoreDataEnd:
                self.endRefreshingWithNoMoreData()
            case .tNoMoreDataReset:
                self.resetNoMoreData()
            case .tHiddenFoot(let b):
                self.hiddenFoot(b)
            }
        }
        return self
    }
    /// 开始刷新
    @discardableResult
    func beginRefreshing() -> CD {
        if !base.mj_header.isRefreshing {
            base.mj_footer?.endRefreshing()
            base.mj_header?.beginRefreshing()
        }
        return self
    }
    /// 结束刷新
    @discardableResult
    func endRefreshing() -> CD {
        base.mj_header?.endRefreshing()
        base.mj_footer?.endRefreshing()
        return self
    }
    /// 结束刷新-无数据
    @discardableResult
    func endRefreshingWithNoMoreData() -> CD {
        base.mj_header?.endRefreshing()
        base.mj_footer?.endRefreshingWithNoMoreData()
        return self
    }
    /// 重置底部刷新
    @discardableResult
    func resetNoMoreData() -> CD {
        base.mj_footer?.resetNoMoreData()
        return self
    }
    /// 隐藏底部刷新
    @discardableResult
    func hiddenFoot(_ b:Bool) -> CD {
        base.mj_footer?.isHidden = b
        return self
    }
}


//MARK:--- 自定义样式 ----------
