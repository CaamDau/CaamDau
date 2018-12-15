//Created  on 2018/12/15  by LCD :https://github.com/liucaide .

import UIKit
import CD
extension VC_TestOne{
    static func show(_ pvc:UIViewController){
        let vc = VC_TestOne.cd_storyboard(name: "TestStoryboard")
        pvc.present(vc, animated: true, completion: nil)
    }
    
}
class VC_TestOne: UIViewController {
    
    @IBAction func clickButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
