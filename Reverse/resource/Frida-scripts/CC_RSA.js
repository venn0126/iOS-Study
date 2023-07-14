// color着色
var Color = {
    RESET: "\x1b[39;49;00m", Black: "0;01", Blue: "4;01", Cyan: "6;01", Gray: "7;01", Green: "2;01", Purple: "5;01", Red: "1;01", Yellow: "3;01",
    Light: {
        Black: "0;11", Blue: "4;11", Cyan: "6;11", Gray: "7;01", Green: "2;11", Purple: "5;11", Red: "1;11", Yellow: "3;11"
    }
};

var LOG = function (input, kwargs) {
    kwargs = kwargs || {};
    var logLevel = kwargs['l'] || 'log', colorPrefix = '\x1b[3', colorSuffix = 'm';
    if (typeof input === 'object')
        input = JSON.stringify(input, null, kwargs['i'] ? 2 : null);
    if (kwargs['c'])
        input = colorPrefix + kwargs['c'] + colorSuffix + input + Color.RESET;
    console[logLevel](input);
};


// [+] --------------------------------------------------------------
// [+] args[0]: /private/var/mobile/Containers/Data/Application/F7302A3F-DDED-42F5-9A5F-9BB714669D0E/Library/Cookies/Cookies.binarycookies
//             0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F  0123456789ABCDEF
// 16b811d18  56 88 ff 20 84 35 07 03 a8 33 95 4d 56 00 3d 35  V.. .5...3.MV.=5
// 16b811d28  9c a3 d5 01 00 00 00 00 6c 00 00 00 00 00 00 00  ........l.......
//             0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F  0123456789ABCDEF
// 16b811d18  56 88 ff 20 84 35 07 03 a8 33 95 4d 56 00 3d 35  V.. .5...3.MV.=5
// 16b811d28  9c a3 d5 01 00 00 00 00 6c 00 00 00 00 00 00 00  ........l.......
// [+] CC_SHA1 Hash: 5688ff20843573a833954d5603d35
// [-] --------------------------------------------------------------
/*

rsa 加密有公钥加密和私钥加密两种方式

```
$frida-trace -UF -i "SecKeyEncrypt" -i "SecKeyRawSign"
```

`SecKeyEncrypt`公钥加密函数对应的 js 代码如下：

```
{
    onEnter(log,args,state){
    //由于同一条加密信息可能会多次调用该函数，故在这输出该函数的调用栈。可根据栈信息去分析上层函数
    log(`SecKeyEncrypt() before string = ${args[2].readCString()}=`);

    log('SecKeyEncryptcalledfrom:\n'+Thread.backtrace(this.context,Backtracer.ACCURATE).map(DebugSymbol.fromAddress).join('\n')+'\n');
}

    onLeave(log,retval,state){

    }
}
```

`SecKeyRawSign`私钥加密函数对应的 js 代码如下：

```
{
    onEnter(log,args,state){
        log(`SecKeyRawSign() before string =${args[2].readCString()}=`);
        log('SecKeyRawSigncalledfrom:\n'+Thread.backtrace(this.context,Backtracer.ACCURATE).map(DebugSymbol.fromAddress).join('\n')+'\n');
    },
    onLeave(log,retval,state){
    
    }
}
```
*/
var ArgPtr = null;
/// 公钥加密
Interceptor.attach(Module.findExportByName('Security', 'SecKeyEncrypt'), {   //CC_SHA1 CC_SHA256 CC_SHA512
    onEnter: function(args) {
        console.log("[+] --------------------------------------------------------------");
        try {
            LOG("[+] args[0]: " + Memory.readUtf8String(args[0], args[1].toInt32()), { c: Color.Gray });
        } catch(e) {
            console.log(hexdump(args[0], {
                length: args[1].toInt32(),
                header: true,
                ansi: true
            }))
        }  

        ArgPtr = args[2];
        // console.log('\tACCURATE Backtrace:\n\t' + Thread.backtrace(this.context,Backtracer.ACCURATE).map(DebugSymbol.fromAddress).join('\n\t'));
    },
  
    onLeave: function(retval) {
        // retval == args[2]
        console.log(hexdump(ArgPtr, {
            length: 32,
            header: true,
            ansi: true
        }))

         console.log(hexdump(retval, {
            length: 32,
            header: true,
            ansi: true
        }))

        var ByteArray = Memory.readByteArray(ArgPtr, 16);
        var uint8Array = new Uint8Array(ByteArray);

        var str = "";
        for(var i = 0; i < uint8Array.length; i++) {
            var hextemp = (uint8Array[i].toString(16))
            if(hextemp.length == 1){
                hextemp = "0" + hextemp
            }
            str += hextemp;
        }
        LOG("[+] Security  SecKeyEncrypt Result: " + str, { c: Color.Cyan });
        console.log("[-] --------------------------------------------------------------\n");
    }
});


/// 私钥加密
// Interceptor.attach(Module.findExportByName('Security', 'SecKeyRawSign'), {   //CC_SHA1 CC_SHA256 CC_SHA512
//     onEnter: function(args) {
//         console.log("[+] --------------------------------------------------------------");
//         try {
//             LOG("[+] args[0]: " + Memory.readUtf8String(args[0], args[1].toInt32()), { c: Color.Gray });
//         } catch(e) {
//             console.log(hexdump(args[0], {
//                 length: args[1].toInt32(),
//                 header: true,
//                 ansi: true
//             }))
//         }  

//         ArgPtr = args[2];
//         // console.log('\tACCURATE Backtrace:\n\t' + Thread.backtrace(this.context,Backtracer.ACCURATE).map(DebugSymbol.fromAddress).join('\n\t'));
//     },
  
//     onLeave: function(retval) {
//         // retval == args[2]
//         console.log(hexdump(ArgPtr, {
//             length: 32,
//             header: true,
//             ansi: true
//         }))

//          console.log(hexdump(retval, {
//             length: 32,
//             header: true,
//             ansi: true
//         }))

//         var ByteArray = Memory.readByteArray(ArgPtr, 16);
//         var uint8Array = new Uint8Array(ByteArray);

//         var str = "";
//         for(var i = 0; i < uint8Array.length; i++) {
//             var hextemp = (uint8Array[i].toString(16))
//             if(hextemp.length == 1){
//                 hextemp = "0" + hextemp
//             }
//             str += hextemp;
//         }
//         LOG("[+] Security  SecKeyRawSign Result: " + str, { c: Color.Cyan });
//         console.log("[-] --------------------------------------------------------------\n");
//     }
// });

