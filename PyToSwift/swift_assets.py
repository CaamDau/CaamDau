#!/usr/bin/python
# coding=utf-8


__author__ = 'LCD'


import os


def file_names(dir):
    path = dir.rstrip()
    try:
        arr = []
        for root, dirs, files in os.walk(path):
            for name in dirs:
                if name.endswith('.imageset'):
                    arr.append(name.split('.imageset')[0])
    except Exception as e:
        raise Exception('资源文件读取失败，请检查路径')
    else:
        return arr



def make_swift(arr, path_output, classname):
    swift = """
//更多代码自动化可了解 :https://github.com/liucaide/CD/tree/master/PyToSwift .
    
import Foundation
import UIKit
import CD

public class %s {
    public init(){}
    """ % classname
    for name in arr:
        img = """
    public lazy var %s:UIImage = {
        return UIImage.cd_podImg(name:"%s", forClass:%s.self)
    }()
        """ % (name, name, classname)
        swift += img

    swift += """
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
    path_input = raw_input("请输入资源文件夹 ~.xcassets 的路径：")
    path_output = raw_input("请输入 ~.swift 保存的路径：")
    name_swift = raw_input("请输入 ~.swift 的文件名：")
    try:
        arr = file_names(path_input)
        make_swift(arr, path_output, name_swift)
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