#!/usr/bin/python3
# coding=utf-8



__author__ = 'LCD'


import plistlib

def read_plist(path):
    with open(path, 'rb') as fp:
        pi = plistlib.load(fp)
    # print(pi)
    return pi


def write_plist(path, obj):
    with open(path, 'wb') as fp:
        plistlib.dump(obj, fp)


def write_swift_config(obj):
    pass


if __name__ == '__main__':
    path = '/Users/lcd/Desktop/MyWorking/CDKit/CD/CD/CD_Config/CD_Config.plist'
    dic = read_plist(path)
    print(dic)
