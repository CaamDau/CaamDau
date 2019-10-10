//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau
import WebKit
import SnapKit
public extension VC_Web{
    class func show() -> VC_Web{
        return VC_Web.cd_storyboard("WebStoryboard", from: "Web") as! VC_Web
    }
    
    class func push(_ style:VC_Web.Style){
        let vc = VC_Web.show()
        vc.webType = style
        vc.hidesBottomBarWhenPushed = true
        CD.push(vc)
    }
}

public class VC_Web: UIViewController {
    @IBOutlet weak var view_progress: UIProgressView!
    @IBOutlet weak var tapBar: CD_TopBar!
    
    
    lazy var webView: WKWebView = {
        let web = WKWebView()
        return web
    }()
    
    var webType:VC_Web.Style = .http("https://github.com/liucaide/CD")
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.webView.observe(\.estimatedProgress) { [weak self](web, change) in
            print_cd(change.newValue)
            self?.view_progress.progress = change.newValue!.floatValue
        }
        
        self.webView.observe(\.estimatedProgress, options: [.new]) { [weak self](web, change) in
            self?.view_progress.progress = change.newValue!.floatValue
        }*/
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        self.view.cd.add(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(tapBar.snp.bottom)
        }
        
        switch self.webType {
        case .http(let str):
            self.webView.load(URLRequest(url: str.urlValue))
            //print_cd(str.urlValue)
        case .html(let str):
            self.webView.loadHTMLString(str, baseURL: "https://github.com/liucaide/CD".urlValue)
        }
        
        self.view.bringSubviewToFront(self.view_progress)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
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

public extension VC_Web {
    enum Style {
        case http(_ urlString:String)
        case html(_ string:String)
    }
}
