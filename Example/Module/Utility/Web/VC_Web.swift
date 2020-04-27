//Created  on 2018/12/16  by LCD :https://github.com/liucaide .



/***** 模块文档 *****
 *
 */

import UIKit
import CaamDau
import WebKit

extension VC_Web:CD_RouterInterface {
    static func router(_ param: CD_RouterParameter, callback: CD_RouterCallback) {
        let vc = VC_Web()
        let style = param.stringValue("router_path")
        switch style {
        case "http":
            vc.webType = Style.http(param.stringValue("url"))
        case "html":
            vc.webType = Style.http(param.stringValue("html"))
        case "file":
            vc.webType = Style.http(param.stringValue("file"))
        default:
            break
        }
        vc._title = param.stringValue("title")
        CD.push(vc)
    }
    
    enum Style {
        case http(_ url:String)
        case html(_ string:String)
        case file(_ string:String)
    }
}

class VC_Web: UIViewController {
    lazy var topBar: CD_TopBar = {
        return CD_TopBar()
    }()
    lazy var webView: WKWebView = {
        let web = WKWebView()
        return web
    }()
    lazy var view_progress: UIProgressView = {
        let v = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        v.tintColor = Config.color.main_1
        return v
    }()
    var webType:Style = .http("https://")
    var _title: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            self.view_progress.isHidden = false
            self.view_progress.alpha = 1
            self.view_progress.setProgress(change!.floatValue("new"), animated: true)
            if change!.floatValue("new") >= 1 {
                UIView.animate(withDuration: 0.3, animations: {[weak self] in
                    self?.view_progress.alpha = 0
                }) { [weak self](b) in
                    self?.view_progress.isHidden = true
                    self?.view_progress.setProgress(0, animated: false)
                }
            }
        }
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension VC_Web {
    func makeUI() {
        self.cd.navigationBar(hidden: true)
        self.view.cd
            .add(topBar)
            .add(self.webView)
            .add(view_progress)
        topBar.delegate = self
        
        makeLayout()
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        switch self.webType {
        case .http(let str):
            self.webView.load(URLRequest(url: str.urlValue))
        case .html(let str):
            self.webView.loadHTMLString(str, baseURL: "https://".urlValue)
        case .file(let str):
            self.webView.load(URLRequest(url: URL(fileURLWithPath: str)))
        }
        
    }
    func makeLayout(){
        topBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        webView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topBar.snp.bottom)
        }
        view_progress.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(topBar)
        }
    }
}

extension VC_Web: CD_TopBarProtocol {
    func topBar(custom topBar: CD_TopBar) {
        topBar._title = _title ?? ""
    }
}
