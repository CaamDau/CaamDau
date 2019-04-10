//Created  on 2019/3/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
import Config

extension VC_MineCollection {
    static func show() -> VC_MineCollection {
        return VC_MineCollection.cd_storyboard(withBundle: "Mine", name: "MineStoryboard") as! VC_MineCollection
    }
    static func push() {
        let vc = VC_MineCollection.show()
        vc.hidesBottomBarWhenPushed = true
        cd_topVC()?.navigationController?.pushViewController(vc, animated: true)
    }
}

class VC_MineCollection: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var vm = VM_MineCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cd.navigationBar(hidden: true)
        self.collectionView.cd
            .background(Config.color.bg)
            .register(self.vm.registerView)
    }
}



extension VC_MineCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.forms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.forms[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm.forms[indexPath.section][indexPath.row].size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = vm.forms[indexPath.section][indexPath.row]
        let cell = collectionView.cd.cell(row.viewId, indexPath)
        row.bind(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return vm.forms[section].first?.x ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return vm.forms[section].first?.y ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return vm.formsHeader[section].insets
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return vm.formsHeader[section].size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        return vm.formsFooter[section].size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if CD<UICollectionView>.CD_Kind.tHeader.stringValue == kind {
            let row = vm.formsHeader[indexPath.section]
            let v = collectionView.cd.view(row.viewId, kind, indexPath)
            row.bind(v)
            return v
        }else{
            let row = vm.formsFooter[indexPath.section]
            let v = collectionView.cd.view(row.viewId, kind, indexPath)
            row.bind(v)
            return v
        }
    }
}
