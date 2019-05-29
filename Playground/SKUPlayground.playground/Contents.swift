import UIKit
import Foundation

/*
 关于奥克斯网批项目 规格选择的算法 重构
 奥克斯规格选择代码存在的问题：
 1、创建了三个多余的规格副本
 2、利用下标进行存取筛选，徒增加代码量和计算复杂度、可读性、维护性都很低
 3、数据结构的使用误区
 
 
 下面对规格选择算法进行重构，我们需要明确几个筛选逻辑问题：
 1、当前选中的规格 now ==> 可增删，单组唯一性
 2、全部可选规格组合 can 与 now 进行匹配 过滤 得到 ==> 新的可选规格组（实时更新）商品编号
 
 从而 明白 利用 Swift API 中 filter{}  map{} contains{} 即可快速 得到结果
 另外 组与组 的匹配 过程 可用 Set -> isSuperset
 */

print((0..<5).map{_ in []})

var now = [["specCode": "colors_WHITE"],
           ["specCode": "energys_0"],
           ["specCode": "powers_0"],
           ["specCode": "frequencys_0"],
           //["specCode": "installTypes_0"]
]

var list = [["specCode": "colors",
             "specAllName": "颜色",
             "specList": [
                ["specCode": "colors_WHITE",
                 "specMeaning": "白色"],
                ["specCode": "colors_Gray",
                 "specMeaning": "灰色"]]],
            
            ["specCode": "energys",
             "specAllName": "能效",
             "specList": [
                ["specCode": "energys_0",
                 "specMeaning": "一级"],
                ["specCode": "energys_1",
                 "specMeaning": "二级"],
                ["specCode": "energys_2",
                 "specMeaning": "三级"]]],
            
            ["specCode": "powers",
             "specAllName": "匹数",
             "specList": [
                ["specCode": "powers_0",
                 "specMeaning": "1匹"
                ],
                ["specCode": "powers_1",
                 "specMeaning": "2匹"
                ],
                ["specCode": "powers_2",
                 "specMeaning": "3匹"
                ]]],
            ["specCode": "frequencys",
             "specAllName": "频率",
             "specList": [
                ["specCode": "frequencys_0",
                 "specMeaning": "变频"],
                ["specCode": "frequencys_1",
                 "specMeaning": "定频"]]],
            ["specCode": "installTypes",
             "specAllName": "安装方式",
             "specList": [
                ["specCode": "installTypes_0",
                 "specMeaning": "挂机"],
                ["specCode": "installTypes_1",
                 "specMeaning": "柜机"]]
    ]]

let can = [["itemCode": "11151210000140",
            "specSku": [["specCode": "colors_WHITE"],
                        ["specCode": "energys_0"],
                        ["specCode": "powers_0"],
                        ["specCode": "frequencys_0"],
                        ["specCode": "installTypes_0"]]],
           ["itemCode": "11151210000141",
            "specSku": [["specCode": "colors_WHITE"],
                        ["specCode": "energys_0"],
                        ["specCode": "powers_0"],
                        ["specCode": "frequencys_0"],
                        ["specCode": "installTypes_1"]]],
           ["itemCode": "11151210000141",
            "specSku": [["specCode": "colors_WHITE"],
                        ["specCode": "energys_0"],
                        ["specCode": "powers_1"],
                        ["specCode": "frequencys_1"],
                        ["specCode": "installTypes_1"]]],
           ["itemCode": "11151210000142",
            "specSku": [["specCode": "colors_Gray"],
                        ["specCode": "energys_1"],
                        ["specCode": "powers_2"],
                        ["specCode": "frequencys_0"],
                        ["specCode": "installTypes_1"]]]]



func canFilter() -> [[String:Any]] {
    return can.filter { (j) -> Bool in
        let arr = j["specSku"] as! [[String:String]]
        let set = Set(arr)
        let setNow = Set(now)
        let bool = set.isSuperset(of: setNow)
        return bool
    }
}
func canMap() -> [[String:Any]] {
    return canFilter().map{$0}
}
func canList() -> [String] {
    /// 过滤 降维 去重
    return Array(Set(Array(canFilter().map{$0["specSku"] as? [[String:String]] ?? []}.joined()).map{$0["specCode"] ?? ""}))
}
func listFilter(_ key:String) -> String {
    // 规格反查
    return list.filter({ (j) -> Bool in
        let arr = j["specList"] as? [[String:String]] ?? []
        let arr2 = arr.map{$0["specCode"] ?? ""}
        let arr3 = now.map{$0["specCode"] ?? ""}
        return Set(arr2).intersection(Set(arr3)).isEmpty
    }).map{$0[key]}.first as? String ?? ""
}

listFilter("specAllName")

print(canMap())
print(canList())

do{
    let skuList = canList()
    for item in list {
        let arr = item["specList"] as? [[String:String]] ?? []
        for sku in arr {
            print(skuList.contains(sku["specCode"] ?? ""))
        }
    }
}




//MARK:--- 下面 我们定义一个模板 使其可通用于所有规格选择 ----------
struct SKU {
    
}


/* 京东 SKU
{
    "code": "0",
    "wareInfo": {
        "image": "https://m.360buyimg.com/n1/jfs/t28012/26/1566663135/443829/c852c101/5ce52568Nf582e6b6.jpg.webp",
        "cartFlag": true,
        "colorSizeInfo": {
            "colorSize": [{
            "buttons": [{
            "no": "1",
            "skuList": ["100001864751", "100002536797", "100002545454"],
            "text": "双子星"
            }, {
            "no": "2",
            "skuList": ["100002536799", "100003887422"],
            "text": "夏日清风"
            }, {
            "no": "3",
            "skuList": ["100003887398", "100003887402"],
            "text": "可爱熊猫"
            }, {
            "no": "4",
            "skuList": ["100002167775", "100003150338"],
            "text": "雨朵"
            }, {
            "no": "5",
            "skuList": ["100003887378", "100003887400"],
            "text": "菠萝"
            }],
            "title": "颜色"
            }, {
            "buttons": [{
            "no": "1",
            "skuList": ["100001864751", "100003150338", "100003887400", "100003887402", "100003887422"],
            "text": "150*200cm"
            }, {
            "no": "2",
            "skuList": ["100002536797"],
            "text": "180*200cm"
            }, {
            "no": "3",
            "skuList": ["100002167775", "100002536799", "100002545454", "100003887378", "100003887398"],
            "text": "200*230cm"
            }],
            "title": "尺码"
            }],
            "colorSizeTips": "#与其他已选项无法组成可售商品，请重选"
        },
        "wareId": "100001864751",
        "price": "48.80",
        "bigImage": ["https://m.360buyimg.com/mobilecms/s750x750_jfs/t28012/26/1566663135/443829/c852c101/5ce52568Nf582e6b6.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/57862/36/388/642572/5cd4f62bE8fe1e993/9db5145f87c641fd.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/35679/28/10204/723481/5cd4f62aE4e4ea5d5/eb08546841cae234.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/58715/19/290/627078/5cd4f62dE4a6f68c3/79ab1f9916cc2e3f.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/14879/28/10488/460542/5c87738bEff185e64/b6207157aa6e0cf5.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/51984/3/352/732043/5cd4f6cfEa0b25a1a/05d4b1b2c21d05ef.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/38600/35/6808/687323/5cd4f6ceE4494c92c/7b13a8261791b896.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/29782/2/15118/461764/5cb84b17Ecfa0aa73/b2755859a08c9432.jpg!q70.jpg.webp", "https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/34379/30/3404/51413/5cb84b29E1f7eead8/e2c49a44455aefd6.jpg!q70.jpg.webp"],
        "brandId": "142001",
        "name": "南极人（NanJiren）夏被被子被褥被芯 水洗棉工艺卡通薄被子空调被纤维被 可水洗 学生儿童通用 150*200cm",
        "stockStatus": "现货",
        "shopId": "1000118982",
        "category": "15248;15249;15257"
    }
}
*/
