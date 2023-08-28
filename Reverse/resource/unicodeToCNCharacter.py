# !/usr/bin/env python3
# -*- coding:utf-8 -*-

'''
to cycript unicode to cn character
'''

from urllib import parse

def addsepline():
    print("-----------------------------------------------------------------------------------------------")

def addseptag():
    print("##################################################################")


def toCNCharacterAction(unicodeStr):

	print('开始转化...')
	str=unicodeStr.encode('unicode_escape')
	print(str)
	strs = str.decode('utf-8').replace('\\x','%')
	print(strs)
	res = parse.unquote(strs)
	print('最种结果>>>' + res)


unicodeStr = '\xe7\x89\x9b***'
toCNCharacterAction(unicodeStr)
