//: [Previous](@previous)

import Foundation
/*
let letters = "abracadabra"
let letterCount = letters.reduce(into: [:]) { counts, letter in
    
    counts[letter, default: 0] += 2
    //print(counts, "->", letter)
}
print(letterCount)
*/

//MARK:--- 升维 组合 ----------
let arr = (0..<15).map{$0}
let arr2 = arr.enumerated().reduce(into: []) { (item, element) in
    if element.offset%4 == 0 {
        item.append([element.element])
    }else{
        var aa = item.last as! [Any]
        aa.append(element.element)
        item[item.count-1] = aa
    }
}

print(arr)
print(arr2)

//MARK:--- 求和等 ----------
//print((1...20).reduce(0, +))
//print((1...4).reduce(1, -))
//print((1...4).reduce(1, *))
//MARK:--- Class Model ----------
/*
 class 模型 filter  map  contains  值修改

class Model {
    var id:String = ""
    var bool:Bool = false
    init(id:String, bool:Bool) {
        self.id = id
        self.bool = bool
    }
}
var arr:[Model] = [Model(id: "1", bool:false),
                   Model(id: "2", bool:true),
                   Model(id: "3", bool:false),
                   Model(id: "4", bool:false),
                   Model(id: "5", bool:true),
                   Model(id: "6", bool:false),
                   Model(id: "7", bool:true),
                   Model(id: "8", bool:false)]



for (i,item) in arr.enumerated() {
    if seleArr.contains(item.id) {
        arr[i].bool = true
    }
}
arr

seleArr.filter { (s) -> Bool in
    arr.filter{$0.id == s}.map{$0.bool = false}
    return false
}
arr

arr.map { (item) -> Model in
    if seleArr.contains(item.id) {item.bool = true}
    return item
}
arr
 */

//MARK:--- struct Model ----------
/*
 struct 模型 filter  map  contains  值修改

struct Model_2 {
    var id:String = ""
    var bool:Bool = false
}
var arr_2:[Model_2] = [Model_2(id: "1", bool:false),
                       Model_2(id: "2", bool:true),
                       Model_2(id: "3", bool:false),
                       Model_2(id: "4", bool:false),
                       Model_2(id: "5", bool:true),
                       Model_2(id: "6", bool:false),
                       Model_2(id: "7", bool:true),
                       Model_2(id: "8", bool:false)]


for (i,item) in arr_2.enumerated() {
    if seleArr.contains(item.id) {
        arr_2[i].bool = true
    }
}
arr_2

arr_2 = arr_2.map { (item) -> Model_2 in
    var model = item
    if seleArr.contains(model.id) {
        model.bool = true
    }
    return model
}
arr_2

// 值匹配组合
let arr2_select = arr_2.compactMap({ (model) -> Model_2? in
    return seleArr.contains{$0 == model.id} ? model : nil
})

//print(arr2_select)
 */

//MARK:--- Json  ----------
/*
 Json 字典 取值 匹配
 */
var json:[[String:Any]] = [["num":3,
                            "id":3,
                            "name":"能效",
                            "tye":3,
                            "list":[["num":0,
                                     "id":"30",
                                     "name":"一级"],
                                    ["num":1,
                                     "id":"31",
                                     "name":"二级"],
                                    ["num":2,
                                     "id":"32",
                                     "name":"三级"]]],
                           ["num":1,
                            "id":1,
                            "name":"频率",
                            "tye":1,
                            "list":[["num":0,
                                     "id":"10",
                                     "name":"变频"],
                                    ["num":1,
                                     "id":"11",
                                     "name":"定频"]]],
                           ["num":2,
                            "id":2,
                            "name":"匹数",
                            "tye":2,
                            "list":[["num":0,
                                     "id":"20",
                                     "name":"一匹"],
                                    ["num":1,
                                     "id":"21",
                                     "name":"二匹"],
                                    ["num":2,
                                     "id":"22",
                                     "name":"三匹"],
                                    ["num":3,
                                     "id":"23",
                                     "name":"四匹"]]]]

// 全选
let a = json.map{["carid":$0["id"]]}
a
let json_select = ["10","20","22","31","32"]
var json_selectArr:[[String:Any]] = []
let json1 = json.compactMap{$0["list"]}
//print(json1)

//let json1 = json.map{$0["list"]}
////print(json1)
//let json2 = json1.filter { (item) -> Bool in
//    (item as! [Any]).filter { (i) -> Bool in
//        print(i)
//        return true
//    }
//    return true
//}

//print(json2)

//let json1= json.map{$0["list"]}.filter({ (item) -> Bool in
//    print(item)
//    return true
//}).map{$0}
//print(json1)
//json_selectArr

/*
json_selectArr = json.compactMap ({ (item) -> [[String:Any]]? in
    
    let arr:[[String:Any]] = item["list"] as! [[String : Any]]
    let list:[[String:Any]] = arr.compactMap({ (item2) -> [String:Any]? in
        return json_select.contains(item2["id"] as! String) ? item2 : [:]
    })
    print(list)
    //return Array(list.joined())
    return list
})
*/

//print(json_selectArr)



//arr = arr.map{ $0.bool = seleArr.contains($0.id) ? true : $0.bool }


//arr.forEach()

//arr = Array(arr.compactMap({ (model) -> [Model]? in
//    model.bool = seleArr.contains{$0 == model.id}
//    return [model]
//}).joined())

/*
 let a = 1
 let b = 3
 let c = [1,2,3]
 
 if a > 1 , b > 3 , c.count > 3 {
 print("正确")
 }else{
 print("错误")
 }
 */



/*
 
 //: [Next](@next)
 
 
 
 var arr1:[String] = []
 for i in 1 ... 5 {
 arr1.append("\(i)")
 }
 arr1
 
 var arr2 = arr1.compactMap { (str) -> [[String]]? in
 return [[str, str, str], [str, str, str], ]
 }
 arr2
 
 var arr3 = Array(arr2.joined())
 var arr4 = Array(arr3.joined())
 var arr5 = Array(arr4.joined(separator: "666"))
 
 var arr6:[Any] = [1, [2,3], 4]
 
 var arr7 = arr6.compactMap { (tt) -> [Int]? in
 switch tt {
 case is [Int]:
 return tt as? [Int]
 case is Int:
 return [tt as! Int]
 default:
 return []
 }
 }
 arr7
 var arr8 = Array(arr7.joined())
 var arr9 = arr6.map{ $0 }
 //var arr9 = arr6.flatMap{ $0 }
 arr9
 
 //var arr7 = Array()
 
 
 
 var dic1: [String:String] = ["aa":"fjdaklfjkd",
 "d":"djflkjd",
 "ss":"dklfjkdl",
 "cc":"djfkljd",
 "www":"djfkljd",
 "s":"dflj",
 "ff":"fdlj",
 "gty":"sdjd",
 "v":"kskfj",
 "ww":"skdks"]
 
 
 dic1.keys
 print(dic1.keys)
 print(dic1.values)
 
 //var arr3 = arr2.starts(with: <#T##Sequence#>, by: <#T##(String, Sequence.Element) throws -> Bool#>)
 
 
 
 
 //print(Array(arr3))
 */
