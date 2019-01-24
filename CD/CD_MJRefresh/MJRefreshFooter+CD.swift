//Created  on 2018/11/5  by LCD :https://github.com/liucaide .

import Foundation
import MJRefresh

//MARK:--- MJRefreshBackNormalFooter 重设置 ----------
public extension CD where Base: MJRefreshBackNormalFooter {
    var activityStyle:UIActivityIndicatorView.Style {
        set{
            base.activityIndicatorViewStyle = newValue
        }
        get{
            return base.activityIndicatorViewStyle
        }
    }
    /// 设置菊花样式
    @discardableResult
    func activityStyle(_ t:UIActivityIndicatorView.Style = .gray) -> CD{
        base.activityIndicatorViewStyle = t
        return self
    }
}
//MARK:--- MJRefreshAutoNormalFooter 重设置 ----------
public extension CD where Base: MJRefreshAutoNormalFooter {
    var activityStyle:UIActivityIndicatorView.Style {
        set{
            base.activityIndicatorViewStyle = newValue
        }
        get{
            return base.activityIndicatorViewStyle
        }
    }
    /// 设置菊花样式
    @discardableResult
    func activityStyle(_ t:UIActivityIndicatorView.Style = .gray) -> CD{
        base.activityIndicatorViewStyle = t
        return self
    }
}
//MARK:--- MJRefreshBackStateFooter 重设置 ----------
public extension CD where Base: MJRefreshBackStateFooter {
    /// 设置文字
    @discardableResult
    func setTitle(isHidden:Bool = true,
                  font:UIFont = UIFont.systemFont(ofSize: 14),
                  color:UIColor = UIColor.lightGray,
                  inset:CGFloat = 0,
                  title:[CD_MJRefreshModel.TitlesEnum] = [.idle(""),
                                                          .pulling(""),
                                                          .refreshing(""),
                                                          .willRefresh(""),
                                                          .noMoreData("")]
        ) -> CD
    {
        base.stateLabel.isHidden = isHidden
        guard !isHidden else {
            return self
        }
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
        base.stateLabel.font = font;
        base.stateLabel.textColor = color
        return self
    }
}
//MARK:--- MJRefreshAutoStateFooter 重设置 ----------
public extension CD where Base: MJRefreshAutoStateFooter {
    /// 设置文字
    @discardableResult
    func setTitle(isHidden:Bool = true,
                  font:UIFont = UIFont.systemFont(ofSize: 14),
                  color:UIColor = UIColor.lightGray,
                  inset:CGFloat = 0,
                  title:[CD_MJRefreshModel.TitlesEnum] = [.idle(""),
                                                          .pulling(""),
                                                          .refreshing(""),
                                                          .willRefresh(""),
                                                          .noMoreData("")]
        ) -> CD
    {
        base.stateLabel.isHidden = isHidden
        guard !isHidden else {
            return self
        }
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
        base.stateLabel.font = font;
        base.stateLabel.textColor = color
        return self
    }
}
//MARK:--- MJRefreshBackGifFooter 重设置 ----------
public extension CD where Base: MJRefreshBackGifFooter {
    /// 设置时间
    @discardableResult
    func setImages(_ images:[CD_MJRefreshModel.ImagesEnum] = [.idle([]),
                                                              .pulling([]),
                                                              .willRefresh([]),
                                                              .refreshing([]),
                                                              .noMoreData([])]
        ) -> CD
    {
        for item in images {
            switch item {
            case .idle(let t):
                base.setImages(t, for: .idle)
            case .pulling(let t):
                base.setImages(t, for: .pulling)
            case .refreshing(let t):
                base.setImages(t, for: .refreshing)
            case .willRefresh(let t):
                base.setImages(t, for: .willRefresh)
            case .noMoreData(let t):
                base.setImages(t, for: .noMoreData)
            }
        }
        return self
    }
}

//MARK:--- MJRefreshAutoGifFooter 重设置 ----------
public extension CD where Base: MJRefreshAutoGifFooter {
    /// 设置时间
    @discardableResult
    func setImages(_ images:[CD_MJRefreshModel.ImagesEnum] = [.idle([]),
                                                              .pulling([]),
                                                              .willRefresh([]),
                                                              .refreshing([]),
                                                              .noMoreData([])]
        ) -> CD
    {
        for item in images {
            switch item {
            case .idle(let t):
                base.setImages(t, for: .idle)
            case .pulling(let t):
                base.setImages(t, for: .pulling)
            case .refreshing(let t):
                base.setImages(t, for: .refreshing)
            case .willRefresh(let t):
                base.setImages(t, for: .willRefresh)
            case .noMoreData(let t):
                base.setImages(t, for: .noMoreData)
            }
        }
        return self
    }
}
