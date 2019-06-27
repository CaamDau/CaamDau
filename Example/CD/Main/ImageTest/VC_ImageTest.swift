//Created  on 2019/1/11  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau
import Util

class Cell_ImageTest: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    lazy var assets:Assets = {
        return Assets()
    }()
}
extension Cell_ImageTest:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        cd_timeConsuming("耗时->\(tag)：") { [weak self] in
            self?.img.image = Assets().share_微信
        }
    }
    
}


class Cell_ImageTestT: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    lazy var assets:Assets = {
        return Assets()
    }()
}
extension Cell_ImageTestT:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        cd_timeConsuming("耗时->\(tag)：") { [weak self] in
            self?.img.image = Assets().logo_launch
        }
    }
    
}


class VC_ImageTest: UICollectionViewController {
    var forms:[CD_RowProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in (0..<100) {
            if item%2 == 0 {
                let row = CD_Row<Cell_ImageTest>(data:"", tag:item)
                forms.append(row)
            }else{
                let row = CD_Row<Cell_ImageTestT>(data:"", tag:item)
                forms.append(row)
            }
            
        }
        
        self.collectionView.reloadData()
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return forms.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = forms[indexPath.row]
        let cell = collectionView.cd.cell(row.viewId, indexPath)
        row.bind(cell)
        return cell
    }
}
