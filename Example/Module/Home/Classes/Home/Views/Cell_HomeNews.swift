//Created  on 2019/1/10  by LCD :https://github.com/liucaide .

import UIKit


public class Cell_HomeNews: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension Cell_HomeNews:CD_RowCellUpdateProtocol{
    public typealias DataSource = Any
    
    public typealias ConfigModel = Any
    public func row_update(dataSource data: DataSource) {
        if let model = data as? M_HomeNews {
            print(lab)
            //img.image = Assets().logo_200
            //lab.text = "LCD"
        }
        //img.image = Assets().logo_200
    }
}
