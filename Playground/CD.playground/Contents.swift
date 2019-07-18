import UIKit
import Foundation

let arr = [1,2,3,4,5,6,7]
arr.forEach { (i) in
    guard i != 3 else { return }
    print(i)
}
