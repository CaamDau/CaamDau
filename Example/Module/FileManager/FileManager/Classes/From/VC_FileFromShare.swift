//Created  on 2019/12/4 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
import Utility

public struct R_FileFromShare {
    public static func push(_ url:URL) {
        let vc = VC_FileFromShare.cd_storyboard("FileStoryboard", from: "FileManager") as! VC_FileFromShare
        vc.url = url
        CD.push(vc)
    }
    
    public static func pushs(_ url:URL) {
        let vc = VC_FileFromShare.cd_storyboard("FileStoryboard", from: "FileManager") as! VC_FileFromShare
        vc.url = url
        CD.present(vc)
    }
}

class VC_FileFromShare: UIViewController {
    lazy var topBar: CD_TopBar = {
        return CD_TopBar()
    }()
    
    
    @IBOutlet weak var btn_icon: UIButton!
    @IBOutlet weak var btn_open: UIButton!
    @IBOutlet weak var btn_save: UIButton!
    
    var url:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cd.navigationBar(hidden: true)
        self.view.cd.add(topBar)
        topBar.delegate = self
        
        
        
        var color = Config.color.file("")//App_File.color("")
        if let url = url {
            color = Config.color.file(CDFileManager.extension(for: url))//App_File.color(CDFileManager.extension(for: url))
        }
        
        btn_icon.cd
            .background(color)
            .background(AssetsFile().fileicon)
            .text(Config.font.font(14))
            .corner(2, clips: true)
        
        btn_open.cd
            .corner(4, clips: true)
            .background(Config.color.main_1)
            .text(Config.font.font(16))
            .text(UIColor.white)
            .text("打开")
        
        btn_save.cd
        .corner(4, clips: true)
        .background(Config.color.main_1)
        .text(Config.font.font(16))
        .text(UIColor.white)
        .text("保存")
    }
    
    lazy var path: String = {
        let path = CDFileManager.pathForDocumentsDirectory(withPath: "file") ?? "file"
        guard !CDFileManager.existsItem(atPath: path) else {
            return path
        }
        guard CDFileManager.createDirectories(forPath: path) else {
            hud_error("文件目录不存在")
            return path
        }
        return path
    }()
    
    @IBAction func buttonClick(_ sender: UIButton) {
        guard let url = url else {return}
        switch sender {
        case btn_open:
            let vc = UIDocumentInteractionController(url: url)
            vc.delegate = self
            vc.presentPreview(animated: true)
        case btn_save:
            let bool = CDFileManager.moveItem(at: url, toPath: path)
            if bool {
                R_FileList.push()
            }else{
                hud_msg("保存失败")
            }
        default:
            break
        }
    }
}

extension VC_FileFromShare: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return CD.window!.rootViewController!
    }
}
//MARK:--- 导航栏 ----------
extension VC_FileFromShare: CD_TopBarProtocol {
    func topBarCustom() {
        if let url = url {
            btn_icon.cd.text(CDFileManager.extension(for: url))
            topBar.cd.snp().title(CDFileManager.name(for: url))
        }else{
            topBar.cd.snp().title("")
        }
    }
}
