function hook_stat(is_pass){
  var stat = Module.findExportByName('libSystem.B.dylib', 'stat');
  Interceptor.attach(stat, {
    onEnter: function(args) {
      // 这里是方法被调用时的处理逻辑
      // args[0] 是 stat 方法的第一个参数，通常是文件路径
      // args[1] 是 stat 方法的第二个参数，这里可以添加其他参数的处理
      console.log('stat is hooked: ');
    },
    onLeave: function(retval){
      if (is_pass){
        retval.replace(-1);
        console.log(`stat retval: ${Number(retval.toString())} -> -1`);
      }
    }
  });
}
 
 
 
function hook_dyld_get_image_name(is_pass){
  let cheek_paths = [
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
  ]
 
  let NSString = ObjC.classes.NSString;
  let true_path = NSString.stringWithString_( "/System/Library/Frameworks/Intents.framework/Intents");
 
 
 
  let _dyld_get_image_name = Module.findExportByName(null, "_dyld_get_image_name");
  Interceptor.attach(_dyld_get_image_name, {
    onEnter: function(args){
 
      console.log("_dyld_get_image_name is hooked.")
      this.idx = eval(args[0]).toString(10);
 
    },
    onLeave: function(retval){
      let rtnStr = retval.readCString();
 
      if(is_pass){
        for (let i=0;i<cheek_paths.length;i++){
 
          if (cheek_paths[i] === rtnStr.toString()){
            retval.replace(true_path);
            console.log(`replace: (${this.idx}) ${rtnStr} => ${true_path}`)
          }
        }
 
      }
 
    }
  })
 
}
 
 
function hook_canopenurl(is_pass){
 
  let api = new ApiResolver("objc");
  api.enumerateMatches("-[UIApplication canOpenURL:]").forEach((matche) => {
 
    console.log("canOpenURL is hooked.");
 
    if (is_pass){
      Interceptor.replace(matche.address, new NativeCallback((url_obj) => {return 0;}, "int", ["pointer"]))
    }
  })
 
 
}
 
// -[NSFileManager fileExistsAtPath:isDirectory:]
function hook_fileExistsAtPath(is_pass){
 
 
  let api = new ApiResolver("objc");
  let matches = api.enumerateMatches("-[NSFileManager fileExistsAtPath:isDirectory:]")
  matches.forEach((matche) => {
 
    console.log("fileExistsAtPath is hooked.");
 
    if(is_pass){
      Interceptor.replace(matche.address, new NativeCallback((path, is_dir) => {
        console.log(ObjC.Object(path).toString(), is_dir)
        return 0;
      }, "int", ["pointer", "bool"]))
    }
 
  })
 
}
 
 
 
function hook_writeToFile(is_pass){
 
  let api = new ApiResolver("objc");
  api.enumerateMatches("-[NSString writeToFile:atomically:encoding:error:]").forEach((matche) => {
 
    Interceptor.attach(matche.address, {
 
      onEnter: function(args){
        this.error = args[5];
        this.path = ObjC.Object(args[2]).toString();
        console.log("writeToFile is hooked");
      },
      onLeave: function(retval){
        if(is_pass){
          let err = ObjC.classes.NSError.alloc();
          Memory.writePointer(this.error, err);
        }
      }
 
    })
 
  })
 
}
 
function hook_lstat(is_pass){
  var stat = Module.findExportByName('libSystem.B.dylib', 'lstat');
  Interceptor.attach(stat, {
    onEnter: function(args) {
 
      console.log('lstat is hooked: ');
    },
    onLeave: function(retval){
      if (is_pass){
        retval.replace(1);
        console.log(`lstat retval: ${Number(retval.toString())} -> 1`);
      }
    }
  });
}
 
function hook_fork(is_pass){
 
  let fork = Module.findExportByName(null, "fork");
  if (fork){
    console.log("fork is hooked.");
    Interceptor.attach(fork, {
      onLeave: function(retval){
        console.log(`fork -> pid:${retval}`);
        if(is_pass){
          retval.replace(-1)
        }
      }
    })
  }
 
}
 
function hook_NSClassFromString(is_pass){
 
  let clses = ["HBPreferences"];
 
  var foundationModule = Process.getModuleByName('Foundation');
  var nsClassFromStringPtr = Module.findExportByName(foundationModule.name, 'NSClassFromString');
 
  if (nsClassFromStringPtr){
    Interceptor.attach(nsClassFromStringPtr, {
      onEnter: function(args){
        this.cls = ObjC.Object(args[0])
        console.log("NSClassFromString is hooked");
      },
      onLeave: function(retval){
 
        if (is_pass){
          clses.forEach((ck_cls) => {
 
            if (this.cls.toString().indexOf(ck_cls) !== -1){
              console.log(`nsClassFromStringPtr -> ${this.cls} - ${ck_cls}`)
              retval.replace(ptr(0x00))
            }
          })
 
        }
 
 
      }
    })
 
  }
 
 
}
 
function hook_getenv(is_pass){
 
  let getenv = Module.findExportByName(null, "getenv");
 
  Interceptor.attach(getenv, {
    onEnter: function(args){
      console.log("getenv is hook");
      this.env = ObjC.Object(args[0]).toString();
    },
    onLeave: function(retval){
      if (is_pass && this.env == "DYLD_INSERT_LIBRARIES"){
        console.log(`env: ${this.env} - ${retval.readCString()}`)
 
        retval.replace(ptr(0x0))
 
      }
 
    }
  })
 
}
 
 
 
setImmediate(() => {
  hook_stat(true);
  hook_dyld_get_image_name(true)
  hook_canopenurl(true);
  hook_fileExistsAtPath(true);
  hook_writeToFile(true);
  hook_lstat(true);
  hook_fork(true);
  hook_NSClassFromString(true);
  hook_getenv(true)
 
})