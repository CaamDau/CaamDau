import UIKit


struct MMM: Codable {
    let code:String
}
let arr = [["code":"1"],["code":"2"]]

let str = #"[{"id":0,"name":"name","img":"img"},{"id":0,"name":"name","img":"img"}]"#

let data = str.data(using: String.Encoding.utf8)!
let decoder = JSONDecoder()
let model = try? decoder.decode(MMM.self, from: data)

