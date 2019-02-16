#!/usr/bin/python3
# coding=utf-8



__author__ = 'LCD'


import plistlib

def read_plist(path):
    path = path.rstrip()
    try:
        with open(path, 'rb') as fp:
            pi = plistlib.readPlist(fp)
    except Exception as e:
        raise Exception('plist文件读取失败，请检查路径')
    else:
        return pi


def make_swift(dic, path_output, classname):
    swift = """
    import Foundation
    import UIKit
    import CD

    public class %s {
    """ % classname
    for key, value in dic.items():
        print key, value
        # swift +=

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
    path_input = raw_input("请输入资源文件夹 ~.plist 的路径：")
    path_output = raw_input("请输入 ~.swift 保存的路径：")
    name_swift = raw_input("请输入 ~.swift 的文件名：")
    try:
        arr = read_plist(path_input)
        # make_swift(arr, path_output, name_swift)
    except Exception as e:
        print e
        setup()
    else:
        print '已完成'
    finally:
        pass


if __name__ == '__main__':
    path = '/Users/lcd/Desktop/MyWorking/CDKit/CD/CD/CD_Config/CD_Config.plist'
    # dic = read_plist(path)
    # print(dic)
    # setup()
    dic = read_plist(path)
    print dic
    for key, value in dic.items():
        print key, value






