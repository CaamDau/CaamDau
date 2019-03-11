#!/usr/bin/python
# coding=utf-8


__author__ = 'LCD'


import re


def read_demo_index_html(path):
    path = path.rstrip()
    try:
        with open(path, 'rb') as fp:
            html = fp.read()  # .decode('gbk')
            # print html
    except Exception as e:
        raise Exception('html文件读取失败，请检查路径')
    else:
        return html

def read_ttf_name(html):
    try:
        pattern = re.compile(r'<p>"(.*?)" 是你项目下的 font-family。可以通过编辑项目查看，默认是 "iconfont"。</p>', re.S)
        basic_content = re.finditer(pattern, html)
        for i in basic_content:
            d = re.match(
                r'<p>"(.*?)" 是你项目下的 font-family。可以通过编辑项目查看，默认是 "iconfont"。</p>',
                i.group(), re.S)
            return d.group(1)
    except Exception as e:
        raise Exception('html解析失败')
    else:
        pass


def read_name_code(html):
    try:
        # 获取所需内容
        pattern = re.compile(r'<span class="icon (.*?)<div class="code-name">&amp;',
                             re.S)
        # 过滤，得到满足条件的内容
        basic_content = re.finditer(pattern, html)
        # 对内容进行加工，得到自己想要的内容
        arr = []
        for i in basic_content:
            dic = {}
            d = re.match(
                r"""<span class="icon (.*?)">&#x(.*?);</span>
                <div class="name">(.*?)</div>""",
                i.group(), re.S)
            dic['font'] = d.group(1)
            str = '\u' + d.group(2)
            dic['code'] = str.decode('unicode-escape').encode('utf-8')
            dic['name'] = d.group(3)
            arr.append(dic)
    except Exception as e:
        raise Exception('html解析失败')
    else:
        # print arr
        return arr


def make_arr_name(list):
    names = []
    for i in range(len(list)):
        name = list[i]['name']
        arr = name.split(' ')
        name = '_'.join(arr)
        arr = name.split('-')
        name = '_'.join(arr)
        if names.count(name) > 0:
            name += '_%s' % str(i)
        names.append(name)
        list[i]['name'] = name
    return list


def make_swift(path_output, classname, arr, pod_key):
    first = arr[0]
    # 头部
    swift = """
    //更多代码自动化可了解 :https://github.com/liucaide/CD/tree/master/PyToSwift .
    
    import Foundation
    import UIKit
    import CD
    
    public enum %s {
        class Help {}
    """ % classname

    # enum
    for item in arr:
        swift += """
        case t%s(_ size:CGFloat)""" % item['name']

    swift += """
    }
    """

    # CD_IconFontProtocol
    swift += """
    extension %s:CD_IconFontProtocol{
        public var font:UIFont {
            return UIFont.iconFont(name: "%s", size: self.size, forClass: %s.Help.self, from: "%s")
        }
        """ % (classname, first['font'], classname,  pod_key)


    swift += """
        public var size: CGFloat {
            switch self {
            case """

    for i in range(len(arr)):
        if i == len(arr)-1:
            swift += """.t%s(let size):
                return size
            }
        }
                    """ % arr[i]['name']
        else:
            swift += """.t%s(let size),
            """ % arr[i]['name']

    swift += """
        public var text: String {
            switch self {"""

    for item in arr:
        swift += """ 
            case .t%s:
                return "%s" """ % (item['name'], item['code'])

    swift += """
            }
        }
    }
    """

    try:
        path = path_output.rstrip()
        file = path + "/" + classname + '.swift'
        with open(file, 'w') as f:
            f.write(swift)
    except Exception as e:
        raise Exception('Swift文件写入错误，请检查路径')


def setup():
    path_input = raw_input("请输入你的iconfont ~_demo_index.html 的路径：")
    path_output = raw_input("请输入你的iconfont ~.swift 保存的路径：")
    name_swift = raw_input("请输入你的iconfont类 ~.swift 的文件名：")
    key_pod = raw_input("如果你使用pod管理该iconfont，请输入你的resource_bundles Key，否则无需输入：")
    # cd_import = raw_input("默认将需要引入 CD 组件，你是否需要：")

    try:
        html = read_demo_index_html(path_input)
        arr = make_arr_name(read_name_code(html))
        make_swift(path_output, name_swift, arr, key_pod)
    except Exception as e:
        print e
        setup()
    else:
        print '已完成'
        next = raw_input("是否继续创建(Y/N)：")
        if next == "Y" or next == "y":
            setup()


if __name__ == '__main__':
    setup()