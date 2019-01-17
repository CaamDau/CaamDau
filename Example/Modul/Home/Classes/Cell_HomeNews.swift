//Created  on 2019/1/10  by LCD :https://github.com/liucaide .

import UIKit
import CD

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
extension Cell_HomeNews:CD_RowUpdateProtocol{
    public typealias DataSource = Any
    public func update(_ data: Any, id: String, tag: Int, frame: CGRect) {
        if let model = data as? M_HomeNews {
            print(lab)
            //lab.text = "LCD"
        }
    }
}
