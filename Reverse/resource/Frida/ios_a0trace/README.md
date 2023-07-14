# ios_a0trace
ios frida 追踪堆栈脚本

简版 objection


### 使用

1. 直接填入需要hook的类，函数。支持模糊hook

> hook("+[Tools md5Encrypt:]");

2. 然后frida执行脚本

> frida -U -F [包名] -l a0trace.js

### 对比图

使用对比的项目地址：[https://github.com/andy0andy/ios_crackme](https://github.com/andy0andy/ios_crackme)

与objection，frida-trace的hook操作比较

[![p9LKPts.png](https://s1.ax1x.com/2023/05/27/p9LKPts.png)](https://imgse.com/i/p9LKPts)


**记录异常**

- Interceptor.attach args为*CGRect*时，app直接崩溃
- Interceptor.attach args为*int*时，app直接崩溃