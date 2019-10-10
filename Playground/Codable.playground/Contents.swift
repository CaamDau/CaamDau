import UIKit

struct MMM: Codable {
    let id:Int
    let name:String
    let img:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case img = "image"
    }
}
let arr = [["code":"1"],["code":"2"]]

let str = #"[{"id":0,"name":"name","image":"img"},{"id":1,"name":"name","image":"imgs"}]"#

let data = str.data(using: String.Encoding.utf8)!
let decoder = JSONDecoder()
let model = try? decoder.decode([MMM].self, from: data)
