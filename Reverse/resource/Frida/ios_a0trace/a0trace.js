

// print color font
// e.g: console.red(s, "cyan")
(function(){
    let colorFontMap = {
        'bright'    : '\x1B[1m', // 亮色
        'grey'      : '\x1B[2m', // 灰色
        'italic'    : '\x1B[3m', // 斜体
        'underline' : '\x1B[4m', // 下划线
        'reverse'   : '\x1B[7m', // 反向
        'hidden'    : '\x1B[8m', // 隐藏
        'black'     : '\x1B[30m', // 黑色
        'red'       : '\x1B[31m', // 红色
        'green'     : '\x1B[32m', // 绿色
        'yellow'    : '\x1B[33m', // 黄色
        'blue'      : '\x1B[34m', // 蓝色
        'magenta'   : '\x1B[35m', // 品红
        'cyan'      : '\x1B[36m', // 青色
        'white'     : '\x1B[37m', // 白色
    }
    let colorBgMap = {
        'black'   : '\x1B[40m', // 背景色为黑色
        'red'     : '\x1B[41m', // 背景色为红色
        'green'   : '\x1B[42m', // 背景色为绿色
        'yellow'  : '\x1B[43m', // 背景色为黄色
        'blue'    : '\x1B[44m', // 背景色为蓝色
        'magenta' : '\x1B[45m', // 背景色为品红
        'cyan'    : '\x1B[46m', // 背景色为青色
        'white'   : '\x1B[47m', // 背景色为白色
    }
    let reset = "\x1B[0m"

    Object.keys(colorFontMap).forEach((color)=>{
        console[color] = function(msg, bgColor){
            console.log(`${colorFontMap[color]}${bgColor ? colorBgMap[bgColor] : ''}${msg}${reset}`);
        }    
    });
})()


// remove duplicates from array
function uniqBy(array, key) 
{
	var seen = {};
	return array.filter(function(item) {
		var k = key(item);
		return seen.hasOwnProperty(k) ? false : (seen[k] = true);
	});

}

function genTimestamp()
{
	var today = new Date();
	var timestamp = today.getFullYear() + '-' + (today.getMonth()+1) + '-' + today.getDate() + ' ' + today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds() + ":" + today.getMilliseconds();
	return timestamp;
}

function buf2hex(buffer) { // buffer is an ArrayBuffer
    return Array.prototype.map.call(new Uint8Array(buffer), x => ('00' + x.toString(16)).slice(-2));
}

function checkVoid(arg_addr){
    let byteArr = Memory.readByteArray(arg_addr, 48);
    let hexArr = buf2hex(byteArr)
    let voidArr = ['a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3', 'a3'];
    let is_void = true;
    for (let i = 0;i < voidArr.length;i++){
        if (voidArr[i] !== hexArr[i]){
            is_void = false;
            break
        }
    }
    return is_void;
}

// convert arg addr to corresponding str
function transArgs(arg_addr){
    let rtnstr = "";

    let baseMod = Process.enumerateModules()[0];
    
    if(parseInt(arg_addr, 16) < parseInt(baseMod.base, 16) 
    || parseInt(arg_addr, 16) > parseInt(baseMod.base.add(baseMod.size), 16)){
        rtnstr = parseInt(arg_addr, 16).toString()
    }else if(checkVoid(arg_addr)){
        rtnstr = "void";
    }else{
        rtnstr = ObjC.Object(arg_addr).toString();
    }


    return rtnstr;
}

function traceObjC(pattern){
    // pattern: 声明

    let type = "objc";
    console.bright(`Instrumenting: ${pattern}\n`); 

    let resolver = new ApiResolver(type);
    let matches = resolver.enumerateMatches(pattern);

    matches.forEach((matche) => {
        console.bright(`Doubtful: ${matche.name}`); 

        // hook
        Interceptor.attach(matche.address, {
            onEnter: function(args){
                
                console.green("\n================================================");
                console.yellow(`*** [${this.threadId}] - ${genTimestamp()} - Enter: ${matche.name} (${matche.address})\n`);

                // 类
                let handle = new ObjC.Object(args[0]);
                // 父类
                let superHandle = handle.$superClass;
                // 类型
                let kind = handle.$kind;
                // 函数
                // let selector = args[1];

                console.cyan(`Called: ${matche.name} | kind: ${kind} | super: ${superHandle.$className}`);                

                // 参数
                let argsCount = (matche.name.match(/:/g) || []).length;
                let param_list = matche.name.split(":");

                console.cyan(`Arguments: ${argsCount}`);
                for(let i=2;i<2+argsCount;i++){
                    if (i == 2){
                        param_list[i-2] = param_list[i-2].split(" ")[1];
                    }
                    
                    let arg_obj = transArgs(args[i]);
                    // let arg_obj = args[i];
                    
                    console.cyan(`\t[${i-2}] ${param_list[i-2]}: => (${arg_obj.$className}) - ${arg_obj.toString()} - (${args[i]})`);
                }

                // 调用堆栈
                console.cyan("\nBacktrace:\n\t" + Thread.backtrace(this.context, Backtracer.ACCURATE).map(DebugSymbol.fromAddress).join('\n\t') + '\n');
                
            },
            onLeave: function(retval){
                let showret  = transArgs(retval);
            
                console.magenta(`Return: ${matche.name} (${matche.address}) => ${showret} - (${retval.toString()})`);
                
                console.yellow(`\n*** [${this.threadId}] - ${genTimestamp()} - Exit: ${matche.name} (${matche.address})`);
                console.green("================================================\n");

                return retval;
            },
        });
    });

        
}

function traceModule(pattern){
    // pattern: 声明

    let type = "module";
    console.bright(`Instrumenting: ${pattern}`); 

    let resolver = new ApiResolver(type);
    let matches = resolver.enumerateMatches(pattern);

    matches.forEach((matche) => {
        // hook
        Interceptor.attach(matche.address, {
            onEnter: function(args){
                
                console.green("\n================================================");
                console.yellow(`*** [${this.threadId}] - ${get_timestamp()} - Enter: ${matche.name} (${matche.address})\n`);

                console.cyan(`Called: ${matche.name}`);         
                
                console.cyan(`\t${hexdump(ptr(args[0]), {length: 64, header: true, ansi: true})}`);

                // 调用堆栈
                // console.cyan("\nBacktrace:\n\t" + Thread.backtrace(this.context, Backtracer.ACCURATE).map(DebugSymbol.fromAddress).join('\n\t') + '\n');
                
            },
            onLeave: function(retval){

                console.magenta(`Return: ${matche.name} (${matche.address}) => ${ObjC.Object(retval)} (${retval})`);
                
                console.yellow(`\n*** [${this.threadId}] - ${get_timestamp()} - Exit: ${matche.name} (${matche.address})`);
                console.green("================================================\n");

                return retval;
            },
        });
    });

        
}

function hook(pattern){
    if (ObjC.available){
        if (pattern.toString().indexOf("!") === -1){
            traceObjC(pattern);
        }else{
            traceModule(pattern);
        }
    }else{
        console.red("iOS load fail...");
    }
}

// main
setImmediate(() => {
    // Modify Here
    // hook("+[Tools md5Encrypt:]"); // 测试

    // hook("-[Tools rtnVoid]");
    // hook("-[Tools rtnStr]");
    // hook("-[Tools rtnBool]");
    // hook("-[Tools rtnInt]");
    hook("*[* *hmac*]")
})

