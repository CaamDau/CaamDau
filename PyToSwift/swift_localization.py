#!/usr/bin/python3
# coding=utf-8



__author__ = 'LCD'


import re


def read_localization_strings(path):
    path = path.rstrip()
    try:
        with open(path, 'rb') as fp:
            strings = fp.read()  # .decode('gbk')
            print strings
    except Exception as e:
        raise Exception('strings文件读取失败，请检查路径')
    else:
        return strings


def read_strings_name(strings):
    try:
        d = re.match(r'"(.*?)" = "(.*?);', strings, re.M|re.I)
        print d.group()
        print d.group(1)
        print d.group(2)
    except Exception as e:
        raise Exception('strings解析失败')
    else:
        pass


def read_name_code(strings):
    try:
        # 获取所需内容
        pattern = re.compile(r'<span class="icon (.*?)<div class="code-name">&amp;',
                             re.S)
        # 过滤，得到满足条件的内容
        basic_content = re.finditer(pattern, strings)
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
        raise Exception('strings解析失败')
    else:
        # print arr
        return arr



if __name__ == '__main__':
    path = "/Users/lcd/Desktop/MyWorking/CDKit/CD/Example/CD/Localization/zh-Hans.lproj/Localization.strings"
    s = read_localization_strings(path)
    print "---------->ss"
    ss = read_strings_name(s)
