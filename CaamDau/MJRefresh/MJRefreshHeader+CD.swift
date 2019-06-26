//Created  on 2018/11/5  by LCD :https://github.com/liucaide .

import Foundation
import MJRefresh

//MARK:--- MJRefreshNormalHeader 重设置 ----------
//MARK:--- MJRefreshAutoFooter 重设置 ----------
public extension CaamDau where Base: MJRefreshHeader {
    /// 忽略多少scrollView的contentInset的bottom
    @discardableResult
    func ignoredContentInsetTop(_ t:CGFloat = 0) -> CaamDau {
        base.ignoredScrollViewContentInsetTop = t
        return self
    }
}
public extension CaamDau where Base: MJRefreshNormalHeader {
    
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
    func activityStyle(_ t:UIActivityIndicatorView.Style = .gray) -> CaamDau {
        base.activityIndicatorViewStyle = t
        return self
    }
}
public extension CaamDau where Base: MJRefreshStateHeader {
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
                                                          .noMoreData(""),]
        ) -> CaamDau
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
        base.labelLeftInset = inset
        base.stateLabel.font = font;
        base.stateLabel.textColor = color
        return self
    }
    
    /// 设置时间
    @discardableResult
    func setTime(isHidden:Bool = true,
                 font:UIFont = UIFont.systemFont(ofSize: 12),
                 color:UIColor = UIColor.lightGray,
                 timeText:((Date)->(String))? = nil
        ) -> CaamDau
    {
        base.lastUpdatedTimeLabel.isHidden = isHidden
        guard !isHidden else {
            return self
        }
        base.lastUpdatedTimeLabel.font = font
        base.lastUpdatedTimeLabel.textColor = color
        base.lastUpdatedTimeText = { (date) -> String in
            return timeText?(date ?? Date()) ?? ""
        }
        return self
    }
}


//MARK:--- MJRefreshGifHeader 重设置 ----------
public extension CaamDau where Base: MJRefreshGifHeader {
    
    /// 设置时间
    @discardableResult
    func setImages(_ images:[CD_MJRefreshModel.ImagesEnum] = [.idle([]),
                                                              .pulling([]),
                                                              .willRefresh([]),
                                                              .refreshing([]),
                                                              .noMoreData([])]
        ) -> CaamDau
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
