//Created  on 2018/12/16  by LCD :https://github.com/liucaide .



/***** 模块文档 *****
 *
 */

import UIKit
import CaamDau
import WebKit
import Utility
import Alamofire

public struct R_FileWeb: CD_RouterInterface {
    public static func router(_ param: CD_RouterParameter = [:], callback: CD_RouterCallback = nil) {
        let vc = VC_FileWeb()
        vc._url = param.stringValue("url")
        vc._title = param.stringValue("title")
        vc.file = param.stringValue("file")
        CD.push(vc)
    }
    
    
    public static func push(_ url:String, title:String, file:String = "file") {
        let vc = VC_FileWeb()
        vc._url = url
        vc._title = title
        vc.file = file
        CD.push(vc)
    }
    
    public static func save(_ url:String, name:String? = nil, file:String = "file"){
        var hud:CD_HUDProgressView?
        var progress:Double = 0 {
            didSet{
                let pr = (progress * 100.0).intValue
                guard pr < 100 else {
                    hud?.progress = CGFloat((1 * 100.0))
                    CD.window?.cd.hud_remove(1)
                    return
                }
                hud?.progress = CGFloat((progress.floatValue * 100.0))
            }
        }
        CD.window?.cd.hud(.progress(.default(model: CD_HUDProgressView.Model(), handler: { (vv) in
            hud = vv
        })), title: "下载中")
        var name = name ?? ""
        var suffix = CDFileManager.extension(forPath: url)!
        if let url = URL(string: url), name.isEmpty  {
            name = CDFileManager.name(for: url)
            suffix = CDFileManager.extension(for: url)
        }
        let destination: DownloadRequest.DownloadFileDestination = { (_, response) in
            //response.suggestedFilename ??
            let names = (name + "." + suffix)
            let path = file + "/" + names
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(path)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        Alamofire
            .download(url, to: destination)
            .downloadProgress(queue: DispatchQueue.main, closure: { (p) in
                progress = p.fractionCompleted
            })
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(_):
                    hud_succeed("已下载")
                case .failure(_):
                    break
                }
            })
    }
}


class VC_FileWeb: UIViewController {
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
    var _url:String = "https://"
    var _title: String?
    var file = "file"
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

extension VC_FileWeb {
    func makeUI() {
        self.cd.navigationBar(hidden: true)
        self.view.cd
            .add(topBar)
            .add(self.webView)
            .add(view_progress)
        topBar.delegate = self
        
        makeLayout()
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        self.webView.load(URLRequest(url: _url.urlValue))
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

extension VC_FileWeb: CD_TopBarProtocol {
    func topBarCustom() {
        topBar._title = _title ?? "文件"
        topBar._style = "11"
        topBar._rightItemsWidth1 = 44
        topBar.cd.white()
        topBar.bar_navigation.line.isHidden = true
    }
    func update(withTopBar item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        switch item {
        case .rightItem1:
            return [.title([(txt: CD_IconFont.tdown(22).text, font: CD_IconFont.tdown(22).font, color: Config.color.txt_1, state: .normal)])]
        default:
            return nil
        }
    }
    
    func didSelect(withTopBar item: CD_TopNavigationBar.Item) {
        super_topBarClick(item)
        switch item {
        case .rightItem1:
            R_FileWeb.save(_url, name: _title, file: self.file)
        default:
            break
        }
    }
    
}
