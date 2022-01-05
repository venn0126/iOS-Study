# Moutai API

## 1.Wechat
### 1.0 auth2
> 向茅台服务发送auth2的token

```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: zh-cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/wechat/auth2/wxca6a32cf7a967782?rdurl=https://reserve.moutai.com.cn/mconsumer/?a=1&code=011zqull2Fe3r74edrol2dDtY24zqulG&state=STATE'


curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Cookie: lambo-sso-key_0_=031huell2F7Gs74No0pl2XL0f54huel0#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Accept-Language: zh-cn' --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/wechat/auth2/wxca6a32cf7a967782?rdurl=https://reserve.moutai.com.cn/mconsumer/?a=1&code=041J740000hv7M1TiA000B3wGk3J740r&state=STATE'



******
some needs

# 自动更新cooike
# 检查用户是否已经预约

1.getOpenId ：
均返回成功
token=-1，request header设置cookie
token=001enGGa1oHjrB020KHa139Yhm4enGGu，requst header没有cookie，response header set cookie

{"code":1,"message":"success","data":{"subscribe":null,"openId":"******","nickname":null,"sexDesc":null,"sex":null,"language":null,"city":null,"province":null,"country":null,"headImgUrl":null,"subscribeTime":null,"unionId":null,"remark":null,"groupId":null,"tagIds":null,"privileges":null,"subscribeScene":null,"qrScene":null,"qrSceneStr":null}}



2. getOpenId post token=001enGGa1oHjrB020KHa139Yhm4enGGu 从哪获取的
3.auth2 get请求拼接参数code= 001enGGa1oHjrB020KHa139Yhm4enGGu进行验证是否合法
4.如果合法则进行接下来的所有请求，否则导致openId失败
5.code从哪来的
6.auth2 code每次请求都不一致，生成规则，以及从何处生成的，
7.auth2 带着code请求，response header token如果cookie有效则，token=-1，否则token=001enGGa1oHjrB020KHa139Yhm4enGGu，就是从cookie失效后的更新cookie的首次code值
8.code如何获取


curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=001enGGa1oHjrB020KHa139Yhm4enGGu' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' --data-binary "token=001enGGa1oHjrB020KHa139Yhm4enGGu" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/wechat/getOpneId'

{"code":1,"message":"success","data":{"subscribe":null,"openId":"******","nickname":null,"sexDesc":null,"sex":null,"language":null,"city":null,"province":null,"country":null,"headImgUrl":null,"subscribeTime":null,"unionId":null,"remark":null,"groupId":null,"tagIds":null,"privileges":null,"subscribeScene":null,"qrScene":null,"qrSceneStr":null}}

{"code":"1001001001","message":"获取openid失败","data":null}



curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: zh-cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/wechat/auth2/wxca6a32cf7a967782?rdurl=https://reserve.moutai.com.cn/mconsumer/?a=1&code=001enGGa1oHjrB020KHa139Yhm4enGGu&state=STATE'

```

### 1.1 getOpenId

```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' --data-binary "token=011zqull2Fe3r74edrol2dDtY24zqulG" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/wechat/getOpneId'


curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=-1' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=031huell2F7Gs74No0pl2XL0f54huel0#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "token=-1" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/wechat/getOpneId'

Respone:
{"code":1,"message":"success","data":{"subscribe":null,"openId":"******","nickname":null,"sexDesc":null,"sex":null,"language":null,"city":null,"province":null,"country":null,"headImgUrl":null,"subscribeTime":null,"unionId":null,"remark":null,"groupId":null,"tagIds":null,"privileges":null,"subscribeScene":null,"qrScene":null,"qrSceneStr":null}}
```



## 2.Consumer
### 2.0 checkUser
```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=011zqull2Fe3r74edrol2dDtY24zqulG#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "custId=******" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/consumer/checkUser'

Response：
{"code":"000","message":"success","data":"用户已经存在"}
```

### 2.1 getUser
> 获取当前用户信息

```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=011zqull2Fe3r74edrol2dDtY24zqulG#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "custId=******" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/consumer/getUser'

Response：
{"code":"000","message":"success","data":{"birthday":"19900126","successTimeTm":0,"gender":"00","city":"120103000","famiAddrs":"天津市河西区友谊北路29号","county":"null","signupTime":"20210630073157","cityValue":"河西区","countyValue":null,"genderValue":"男","cityName":"天津","province":"120000000","successTime":0,"custId":"******","tel":"13612163657","idAddr":"天津市河西区","phoneType":"移动","successTimeHy":0,"custName":"牛威","identityNum":"130528199001260415","provinceValue":"天津市","upTime":null,"famiAddr":"天津市河西区友谊北路29号","provinceName":"天津","age":null,"status":"00"}}

```

### 2.1 getShops
> 获取可预约的店铺列表

```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=071q9wGa1qTUsB0BjxHa1YMEze2q9wGJ' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=071q9wGa1qTUsB0BjxHa1YMEze2q9wGJ#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "custId=******" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/consumer/getShops'

Response：
{"code":"000","message":"success","data":[{"V":"黑龙江自营店","K":"MT_HLJHEB1001"},{"V":"江西自营店","K":"MT_JXNC1001"}]}

```


## 3.Register
### 3.0 getSlideCode
> 获取滑动验证code

```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=011zqull2Fe3r74edrol2dDtY24zqulG#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/register/getSlideCode'

Response:
{"code":"000","message":"success","data":{"psb":"xxx"}}

```

### 3.1 checkSlideCode
> 验证滑动是否合法

```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=011zqull2Fe3r74edrol2dDtY24zqulG#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "sfg=78" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/register/checkSlideCode'

Response:
{"code":"100","message":"failed","data":"验证失败，请重试！"}

{"code":"000","message":"success","data":"ok"}

```

## 4.reserve

### 4.0 checkReserve
```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=011zqull2Fe3r74edrol2dDtY24zqulG#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "custId=******" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/reserve/checkReserve'

Response:
{"code":"100","message":"failed","data":"检查失败，30天内已预约购酒"}

```

### 4.1 list
```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=011zqull2Fe3r74edrol2dDtY24zqulG#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "custId=******&offset=0&limit=1000" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/reserve/list'

Response:
{"code":"000","message":"success","data":{"total":5,"rows":[{"note":null,"approvalDate":null,"approvalTime":null,"custName":"牛威","creaDate":"20210724100245","statuaValue":"待确认","lwId":"1418753488238534656","approvalTimeName":null,"clientIp":"219.142.184.8","custId":"******","tenantId":"MT_BJ","pickupDate":null,"pickupCode":null,"shopId":"MT_BJ1001","applyDate":"20210724","applyTime":"10:02:45","status":"10"},{"note":"抱歉，由于名额有限，您的预约未被系统抽中，请明天重新预约，感谢您的参与！","approvalDate":null,"approvalTime":null,"custName":"牛威","creaDate":"20210723090504","statuaValue":"未成功","lwId":"1418376583169134592","approvalTimeName":null,"clientIp":"123.126.70.234","custId":"******","tenantId":"MT_BJ","pickupDate":null,"pickupCode":null,"shopId":"MT_BJ1001","applyDate":"20210723","applyTime":"09:05:04","status":"90"},{"note":"抱歉，由于名额有限，您的预约未被系统抽中，请明天重新预约，感谢您的参与！","approvalDate":null,"approvalTime":null,"custName":"牛威","creaDate":"20210722090537","statuaValue":"未成功","lwId":"1418014335747612672","approvalTimeName":null,"clientIp":"123.126.70.234","custId":"******","tenantId":"MT_TJ","pickupDate":null,"pickupCode":null,"shopId":"MT_TJ1001","applyDate":"20210722","applyTime":"09:05:37","status":"90"},{"note":"抱歉，由于名额有限，您的预约未被系统抽中，请明天重新预约，感谢您的参与！","approvalDate":null,"approvalTime":null,"custName":"牛威","creaDate":"20210721092108","statuaValue":"未成功","lwId":"1417655850118275072","approvalTimeName":null,"clientIp":"123.126.70.234","custId":"******","tenantId":"MT_TJ","pickupDate":null,"pickupCode":null,"shopId":"MT_TJ1001","applyDate":"20210721","applyTime":"09:21:08","status":"90"},{"note":"抱歉，由于名额有限，您的预约未被系统抽中，请明天重新预约，感谢您的参与！","approvalDate":null,"approvalTime":null,"custName":"牛威","creaDate":"20210630073257","statuaValue":"未成功","lwId":"1410018481141063680","approvalTimeName":null,"clientIp":"221.222.21.147","custId":"******","tenantId":"MT_NXYC","pickupDate":null,"pickupCode":null,"shopId":"MT_NXYC1001","applyDate":"20210630","applyTime":"07:32:57","status":"90"}]}}
```

### 4.2 detail
```
curl -H 'Host: reserve.moutai.com.cn' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-cn' -H 'Cache-Control: no-cache' -H 'token: ' -H 'Origin: https://reserve.moutai.com.cn' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.9(0x18000927) NetType/WIFI Language/zh_CN' -H 'Referer: https://reserve.moutai.com.cn/mconsumer/?a=1&token=011zqull2Fe3r74edrol2dDtY24zqulG' -H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' -H 'Cookie: lambo-sso-key_0_=011zqull2Fe3r74edrol2dDtY24zqulG#TufG1lVGWNpd6TKDPmF4+SzpKCR68NZIksTLh9DPKVk=' --data-binary "lwId=1418753488238534656&custId=******" --compressed 'https://reserve.moutai.com.cn/api/rsv-server/anon/reserve/detail'

Response:
{"code":"000","message":"success","data":{"note":null,"approvalDate":null,"approvalTime":null,"custName":"牛威","creaDate":"20210724100245","statuaValue":"待确认","lwId":"1418753488238534656","approvalTimeName":null,"clientIp":"219.142.184.8","custId":"******","tenantId":"MT_BJ","pickupDate":null,"pickupCode":null,"itemList":[{"itemName":"飞天53%vol 1L贵州茅台酒（1×6）","lwId":"1418753488238534656","outprice":3799,"qty":2,"itemCode":"483","unitId":"10","unitValue":"瓶"}],"shopId":"MT_BJ1001","applyDate":"20210724","applyTime":"10:02:45","status":"10"}}
```
