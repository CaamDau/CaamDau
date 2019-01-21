/**
 * generate from Hemera
 * https://github.com/JianweiWangs/Hemera.git
 * JianweiWangs
 * MyImage.swift
 */

import UIKit
struct MyImage {
    private(set) lazy var dark: UIImage = {
        return UIImage(named: darkName)!
    }()
    private(set) lazy var light: UIImage = {
        return UIImage(named: lightName)!
    }()
    private let darkName: String
    private let lightName: String
    private init(darkName: String, lightName: String) {
        self.darkName = darkName
        self.lightName = lightName
    }

    public static var 评论_: MyImage = {
    	return MyImage(darkName: "评论_", lightName:"评论_")
    }()

    public static var 搜索_常规: MyImage = {
    	return MyImage(darkName: "搜索_常规", lightName:"搜索_常规")
    }()

    public static var 评论_icon: MyImage = {
    	return MyImage(darkName: "评论_icon", lightName:"评论_icon")
    }()

    public static var 消息_常规: MyImage = {
    	return MyImage(darkName: "消息_常规", lightName:"消息_常规")
    }()

    public static var 分享_常规: MyImage = {
    	return MyImage(darkName: "分享_常规", lightName:"分享_常规")
    }()

    public static var 返回_常规: MyImage = {
    	return MyImage(darkName: "返回_常规", lightName:"返回_常规")
    }()

    public static var 返回首页_常规: MyImage = {
    	return MyImage(darkName: "返回首页_常规", lightName:"返回首页_常规")
    }()

    public static var sight_top_toolbar_close: MyImage = {
    	return MyImage(darkName: "sight_top_toolbar_close", lightName:"sight_top_toolbar_close")
    }()

    public static var 分享_图标: MyImage = {
    	return MyImage(darkName: "分享 图标", lightName:"分享 图标")
    }()

    public static var 已选_按钮: MyImage = {
    	return MyImage(darkName: "已选_按钮", lightName:"已选_按钮")
    }()

    public static var com_点赞动画01: MyImage = {
    	return MyImage(darkName: "com_点赞动画01", lightName:"com_点赞动画01")
    }()

    public static var com_向左_灰: MyImage = {
    	return MyImage(darkName: "com_向左_灰", lightName:"com_向左_灰")
    }()

    public static var 未选_按钮: MyImage = {
    	return MyImage(darkName: "未选_按钮", lightName:"未选_按钮")
    }()

    public static var 点赞__未点击_icon: MyImage = {
    	return MyImage(darkName: "点赞__未点击_icon", lightName:"点赞__未点击_icon")
    }()

    public static var 返回_白色: MyImage = {
    	return MyImage(darkName: "返回_白色", lightName:"返回_白色")
    }()

    public static var 返回首页_白色: MyImage = {
    	return MyImage(darkName: "返回首页_白色", lightName:"返回首页_白色")
    }()

    public static var com_点赞动画04: MyImage = {
    	return MyImage(darkName: "com_点赞动画04", lightName:"com_点赞动画04")
    }()

    public static var 01_设置0s: MyImage = {
    	return MyImage(darkName: "01_设置0s", lightName:"01_设置0s")
    }()

    public static var com_向右_灰: MyImage = {
    	return MyImage(darkName: "com_向右_灰", lightName:"com_向右_灰")
    }()

    public static var com_历史: MyImage = {
    	return MyImage(darkName: "com_历史", lightName:"com_历史")
    }()

    public static var com_消息_白: MyImage = {
    	return MyImage(darkName: "com_消息_白", lightName:"com_消息_白")
    }()

    public static var com_点赞动画03: MyImage = {
    	return MyImage(darkName: "com_点赞动画03", lightName:"com_点赞动画03")
    }()

    public static var com_点赞动画02: MyImage = {
    	return MyImage(darkName: "com_点赞动画02", lightName:"com_点赞动画02")
    }()

    public static var com_点赞_正点: MyImage = {
    	return MyImage(darkName: "com_点赞_正点", lightName:"com_点赞_正点")
    }()

    public static var 分享_白色: MyImage = {
    	return MyImage(darkName: "分享_白色", lightName:"分享_白色")
    }()

    public static var 屏蔽_按钮_: MyImage = {
    	return MyImage(darkName: "屏蔽_按钮_", lightName:"屏蔽_按钮_")
    }()

    public static var 板块标题_更多_icon: MyImage = {
    	return MyImage(darkName: "板块标题_更多_icon", lightName:"板块标题_更多_icon")
    }()

    public static var 收藏_未点击: MyImage = {
    	return MyImage(darkName: "收藏_未点击", lightName:"收藏_未点击")
    }()

    public static var share_QQ: MyImage = {
    	return MyImage(darkName: "share-QQ", lightName:"share-QQ")
    }()

    public static var share_举报: MyImage = {
    	return MyImage(darkName: "share-举报", lightName:"share-举报")
    }()

    public static var share_微信: MyImage = {
    	return MyImage(darkName: "share-微信", lightName:"share-微信")
    }()

    public static var share_新浪: MyImage = {
    	return MyImage(darkName: "share-新浪", lightName:"share-新浪")
    }()

    public static var share_朋友圈: MyImage = {
    	return MyImage(darkName: "share-朋友圈", lightName:"share-朋友圈")
    }()

    public static var share_链接: MyImage = {
    	return MyImage(darkName: "share-链接", lightName:"share-链接")
    }()

    public static var com_搜索_白: MyImage = {
    	return MyImage(darkName: "com_搜索_白", lightName:"com_搜索_白")
    }()

    public static var 收藏_已点击: MyImage = {
    	return MyImage(darkName: "收藏_已点击", lightName:"收藏_已点击")
    }()

    public static var refresh_3: MyImage = {
    	return MyImage(darkName: "refresh_3", lightName:"refresh_3")
    }()

    public static var refresh_2: MyImage = {
    	return MyImage(darkName: "refresh_2", lightName:"refresh_2")
    }()

    public static var refresh_4: MyImage = {
    	return MyImage(darkName: "refresh_4", lightName:"refresh_4")
    }()

    public static var refresh_5: MyImage = {
    	return MyImage(darkName: "refresh_5", lightName:"refresh_5")
    }()

    public static var refresh_0: MyImage = {
    	return MyImage(darkName: "refresh_0", lightName:"refresh_0")
    }()

    public static var refresh_1: MyImage = {
    	return MyImage(darkName: "refresh_1", lightName:"refresh_1")
    }()

    public static var refresh_7: MyImage = {
    	return MyImage(darkName: "refresh_7", lightName:"refresh_7")
    }()

    public static var refresh_6: MyImage = {
    	return MyImage(darkName: "refresh_6", lightName:"refresh_6")
    }()

    public static var 200x200: MyImage = {
    	return MyImage(darkName: "200x200", lightName:"200x200")
    }()

    public static var 60x60: MyImage = {
    	return MyImage(darkName: "60x60", lightName:"60x60")
    }()

    public static var launchScreen: MyImage = {
    	return MyImage(darkName: "launchScreen", lightName:"launchScreen")
    }()

    public static var logo_0: MyImage = {
    	return MyImage(darkName: "logo_0", lightName:"logo_0")
    }()

    public static var 20x20: MyImage = {
    	return MyImage(darkName: "20x20", lightName:"20x20")
    }()

    public static var 40x40: MyImage = {
    	return MyImage(darkName: "40x40", lightName:"40x40")
    }()

    public static var 30x30: MyImage = {
    	return MyImage(darkName: "30x30", lightName:"30x30")
    }()

}
