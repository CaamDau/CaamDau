//Created  on 2018/11/23 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */



import Foundation
import UIKit


public struct CD_MJRefreshModel {
    /// 下拉闲置状态 文字
    public var down_txtIdle = ""
    /// 下拉提示松开状态 文字
    public var down_txtPulling = ""
    /// 下拉即将刷新状态
    public var down_txtWillRefresh = ""
    /// 下拉松开正在刷新状态
    public var down_txtRefreshing = ""
    /// 下拉数据加载完毕状态
    public var down_txtNoMoreData = ""
    
    /// 下拉闲置状态 图片
    public var down_imgIdle:[UIImage] = []
    /// 下拉提示松开状态 图片
    public var down_imgPulling:[UIImage] = []
    /// 下拉即将刷新状态 图片
    public var down_imgWillRefresh:[UIImage] = []
    /// 下拉松开正在刷新状态 图片
    public var down_imgRefreshing:[UIImage] = []
    /// 下拉数据加载完毕状态 图片
    public var down_imgNoMoreData:[UIImage] = []
    
    /// 下拉刷新状态的Label字体
    public var down_txtFont:UIFont = UIFont.systemFont(ofSize: 14)
    /// 下拉刷新状态的Label文字颜色
    public var down_txtColor:UIColor = UIColor.cd_hex("d3", dark: "f0")
    /// 下拉刷新状态的Label是否隐藏
    public var down_txtHidden:Bool = true
    /// 下拉刷新状态的Label字体
    public var down_timeFont:UIFont = UIFont.systemFont(ofSize: 12)
    /// 下拉刷新状态的Label文字颜色
    public var down_timeColor:UIColor = UIColor.cd_hex("d3", dark: "f0")
    /// 下拉刷新状态的Label是否隐藏
    public var down_timeHidden:Bool = true
    /// 下拉文字和图片间的距离
    public var down_leftInset:CGFloat = 0
    /// 下拉菊花样式
    public var down_activityStyle:UIActivityIndicatorView.Style = .gray
    /// 下拉时间格式自定义
    public var down_timeText:((Date)->(String))?
    
    
    /// 上拉闲置状态 文字
    public var up_txtIdle = "上拉加载更多"
    /// 上拉提示松开状态 文字
    public var up_txtPulling = "放手是一种态度"
    /// 上拉即将刷新状态
    public var up_txtWillRefresh = "拼命加载中..."
    /// 上拉松开正在刷新状态
    public var up_txtRefreshing = "拼命加载中..."
    /// 上拉数据加载完毕状态
    public var up_txtNoMoreData = "没有更多数据"
    
    /// 上拉刷新状态的Label字体
    public var up_txtFont:UIFont = UIFont.systemFont(ofSize: 14)
    /// 上拉刷新状态的Label文字颜色
    public var up_txtColor:UIColor = UIColor.cd_hex("d3", dark: "f0")
    /// 上拉刷新状态的Label是否隐藏
    public var up_txtHidden:Bool = false
    /// 上拉文字和图片间的距离
    public var up_leftInset:CGFloat = 15
    /// 下拉菊花样式
    public var up_activityStyle:UIActivityIndicatorView.Style = .gray
    
    /// 上拉闲置状态 图片
    public var up_imgIdle:[UIImage] = []
    /// 上拉提示松开状态 图片
    public var up_imgPulling:[UIImage] = []
    /// 上拉即将刷新状态 图片
    public var up_imgWillRefresh:[UIImage] = []
    /// 上拉松开正在刷新状态 图片
    public var up_imgRefreshing:[UIImage] = []
    /// 上拉数据加载完毕状态 图片
    public var up_imgNoMoreData:[UIImage] = []
    
    
    
    
    /// 忽略多少scrollView的contentInset的bottom
    public var ignoredContentInsetBottom:CGFloat = 0
    /// 忽略多少scrollView的contentInset的Top
    public var ignoredContentInsetTop:CGFloat = 0
    /// 是否禁止自动加载
    public var isAutoRefresh:Bool = true
    /// 当底部控件出现多少时就自动刷新
    public var autoRefreshPercent:CGFloat = 1
    /// 是否每一次拖拽只发一次请求
    public var onlyRefreshPerDrag:Bool = false
    
    public init() {}
    
    
    
    public enum TitlesEnum {
        case idle(_ t:String)
        case pulling(_ t:String)
        case refreshing(_ t:String)
        case willRefresh(_ t:String)
        case noMoreData(_ t:String)
    }
    
    public enum ImagesEnum {
        case idle(_ t:[UIImage])
        case pulling(_ t:[UIImage])
        case refreshing(_ t:[UIImage])
        case willRefresh(_ t:[UIImage])
        case noMoreData(_ t:[UIImage])
    }
    
    
    //MARK:--- 刷新状态更新 ----------
    public enum RefreshType {
        case tBegin
        case tEnd
        case tNoMoreDataEnd
        case tNoMoreDataReset
        case tHiddenFoot(_ b:Bool)
        
        var intValue:Int {
            switch self {
            case .tBegin:
                return 0
            case .tEnd:
                return 1
            case .tNoMoreDataEnd:
                return 2
            case .tNoMoreDataReset:
                return 3
            case .tHiddenFoot:
                return 4
            }
        }
    }
}

public class CD_MJRefresh{
    private init(){}
    public static let shared = CD_MJRefresh()
    public var model = CD_MJRefreshModel()
}
