# !/usr/bin/env python3
# -*- coding:utf-8 -*-

'''
monitor a product stock and add a new product
'''

import requests
import json 
import jsonpath
import time
from bs4 import BeautifulSoup as bs
import copy
from discord_webhook import DiscordWebhook, DiscordEmbed
import pickle


def addsepline():
    print("-----------------------------------------------------------------------------------------------")

def addseptag():
    print("##################################################################")


def update_shopify_db(webhookLink,productLink):

		print('开始监控...')
		# url = 'https://undefeated.com/products/og-era-lx-paisley-truewhite'	
		link = productLink + '.json'
		working = False

		# price_format = '¥{}'.format(price)
		cookie = 'mp_56fa4377ba1b82a4378b4798_mixpanel=%7B%22distinct_id%22%3A%20%22181db195ab7db9-0345ddf8560d998-427c77-4a574-181db195ab8e0e%22%7D; mp_mailogs__c=59'
		headers = {
	        'Host': 'wc.nike.com.cn',
		    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
		    'Accept-Language': 'zh-cn',
		    'user-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Mobile/15E148 Safari/604.1',
		    'Cookie': cookie,
		    'Accept-Encoding' : 'gzip, deflate, br',
		    'Connection' : 'keep-alive'
   		 }

		# temp varible
		current_city_V = []
		productName = 'BJMT'
		price = '1499¥'
		hypePicLink = ''
		

		try:
			r = requests.get(link,timeout=3, headers=headers)
			working = True
		except:
			try:
				r = requests.get(link,timeout=5, headers=headers)
				working = True
			except:
				working = False

		
		if working:
			product_json=r.text
			print(product_json)
			# {"code":"000","message":"success","data":[{"V":"黑龙江自营店","K":"MT_HLJHEB1001"},{"V":"江西自营店","K":"MT_JXNC1001"},{"V":"宁夏自营店","K":"MT_NXYC1001"}]}
			#json string to py obj
			# print(product_dict)
			# print(cityVs[0])
			# if type(cityVs) == list:
			# 	if any("北京自营店" in s for s in cityVs):
			# 		print("BJ is here")
			# 	else:
			# 		print("BJ is not here")
			# 	# current list append
			# 	for v in cityVs:
			# 		current_city_V.append(v)
			# else:
			# 	print(product_dict["message"])
			# 	return


		# next_city_city_V = []
		# while True:
		
		# 	# 对比
		# 	if current_city_V != next_city_city_V:
		# 		print('city update...')
		# 		print(current_city_V)
		# 		send_webhook(webhookLink,'Moutai',current_city_V)
	 #   			# 赋值
		# 		next_city_city_V = copy.deepcopy(current_city_V)


		# 	try:
		# 		r = requests.post(link,timeout=3, headers=headers,data=payload)
		# 		working = True
		# 	except:
		# 		try:
		# 			r = requests.post(link,timeout=5, headers=headers,data=payload)
		# 			working = True
		# 		except:
		# 			working = False

		# 	if working:
	 # 			product_json = r.text
	 # 			product_dict = json.loads(product_json)
	 # 			cityVs = jsonpath.jsonpath(product_dict,expr='$.data[*].V')	
	 # 			if type(cityVs) == list:
	 # 				if any("北京自营店" in s for s in cityVs):
	 # 					print("BJ is here")
	 # 					# send webhook
	 # 				else:
	 # 					print("BJ is not here")

	 # 				if current_city_V:
	 # 					current_city_V.clear()
	 # 				for v in cityVs:
	 # 					current_city_V.append(v)
	 # 			else:
	 # 				# cookie invalid
	 # 				print(product_dict["message"])
	 # 				break

			time.sleep(5)


# update cookies
def getCookies():

	cookiesDict = {}
	headers = {
	        'Host': 'reserve.moutai.com.cn',
		    'Accept': 'application/json, text/plain, */*',
		    'Accept-Language': 'zh-cn',
		    'user-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN',
		    'Accept-Encoding' : 'gzip, deflate, br',
		    'Cache-Control' : 'no-cache',
		    'Origin' : 'https://reserve.moutai.com.cn',
		    'Connection' : 'keep-alive',
		    'Referer' : 'https://reserve.moutai.com.cn/mconsumer/?a=1&token=001enGGa1oHjrB020KHa139Yhm4enGGu',
		    'Content-Type' : 'application/x-www-form-urlencoded;charset=UTF-8',

   	}
	
	url = 'https://reserve.moutai.com.cn/api/rsv-server/anon/wechat/getOpneId'
	data = {'token' : '091kJm000ZWT4N1xIq200PzUIL0kJm08'}
	session = requests.session()
	resp = session.post(url = url, headers = headers,timeout = 30,data = data)
	print(resp.cookies.get_dict())
	print(resp.text)
	# with open('./cookies.txt') as f:
	# 	cookies = pickle.loads(f.read())
	# for cookie in cookies:
	# 	cookiesDict[cookie['name']] = cookie['value']
	# session.cookies.update(cookiesDict)
	# print(cookiesDict)


# send update city notify
def send_webhook(webhookLink,productName,sizeList):
	# price_format = '¥{}'.format(price)
	# embed
	webhook = DiscordWebhook(url=webhookLink, username='Moutai',avatar_url='https://cdn.cybersole.io/media/discord-logo.png')

	embed = DiscordEmbed(title=productName, description='', color=65280)
	# embed.add_embed_field(name='Price', value=price_format,inline=False)
	for index in range(len(sizeList)):
		# carLink = 'https://undefeated.com/cart/{}:1'.format(idList[index])
		# value_format = '[{}]({})'.format(idList[index],carLink)
		embed.add_embed_field(name=index,value=sizeList[index])

	embed.set_footer(text='AugusAIO',icon_url='https://cdn.discordapp.com/attachments/569722032137437191/677350898556600355/kobe.jpg')
	embed.set_timestamp()
	# embed.set_thumbnail(url=hypePicLink)
	webhook.add_embed(embed)
	response = webhook.execute()
	print("数据发送中,请稍后...")
	if response.status_code == 204:
		print('恭喜🎉!!!Moutai预约城市更新通知发送成功!')
	else:
		print('很遗憾😭...Moutai预约城市更新通知发送失败,请检查输入参数.')

	


webhookLink = input("请输入webhook link():")
if webhookLink == "":
	webhookLink = "https://discord.com/api/webhooks/994778792637775925/Q1JJlYU1U1SNTVru_VvvkexoWbfe5MCYRd2iAlnfbJZuMIBK4MYy55W_8KqRoagYLDJN"
print(webhookLink)
addseptag()

# getCookies()
productLink = input("请输入要监控单品链接(默认https://undefeated.com/products/og-era-lx-paisley-truewhite):")
if productLink == "":
	productLink = "https://wc.nike.com.cn/627b845b06381e44cc6bf713/h5/nikesnkrs/index.html#!/oto/poster"

print(productLink)
addseptag()


update_shopify_db(webhookLink,productLink)






        	




