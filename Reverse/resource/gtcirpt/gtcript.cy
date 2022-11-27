(function(exports){

	// 定义全局报错信息
	var invaldParamStr = 'Invalid parameter'
	var missedParamStr = 'Missed parameter'

	// app id
	GTAppId = [NSBundle mainBundle].bundleIdentifier;

	// app path
	GTAppPath = [NSBundle mainBundle].bundlePath;

	// document path
	GTDocPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

	// caches path
	GTCachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];

	// 加载系统动态库
	GTLoadFramework = function(name) {
		var head = "/System/Library/"
		var foot = "Frameworks/" + name + ".framework"
		var bundle = [NSBundle bundleWithPath:head + foot] || [NSBundle bundleWithPath:head + "Private" + foot];
		[bundle load];
		return bundle;
	};

	// kew window
	GTKeyWin = function() {
		return UIApp.keyWindow;
	};

	// root viewController
	GTRootVc = function() {
		return UIApp.keyWindow.rootViewController;
	};

	// 递归找到最前面的控制器
	var _GTFrontVc = function (vc) {
		if(vc.presentedViewController) {
			return _GTFrontVc(vc.presentedViewController);
		} else if([vc isKindOfClass:[UITabBarController class]]){
			return _GTFrontVc(vc.selectedViewController);
		} else if([vc isKindOfClass:[UINavigationController class]]) {
			return _GTFrontVc(vc.visibleViewController);
		} else {
			var count = vc.childViewControllers.count;
			for (var i = count - 1; i >= 0; i--) {
				var childVc = vc.childViewControllers[i];
				if(childVc && childVc.view.window) {
					vc = _GTFrontVc(childVc);
					break;
				}
			}
			return vc;
		}
	};

	GTFrontVc = function() {
		return _GTFrontVc(UIApp.keyWindow.rootViewController)
	};

	// 递归打印controller的层级结构
	GTChildVcs = function(vc) {
		if(![vc isKindOfClass:[UIViewController class]]) throw new Error(invaldParamStr);
		return [vc _printHierarchy].toString();
	};

	// 递归打印最上层UIViewController view的层级结构
	GTFrontVcSubviews = function() {
		return GTVcSubviews(_GTFrontVc(UIApp.keyWindow.rootViewController));
	};

	// 获取按钮绑定的所有touchUpInside事件的方法名
	GTButtonTouchUpEvents = function (button) {
		var events = [];
		var allObjects = button.allTargets.allObjects;
		var count = allObjects.count;
		for (var i = count - 1; i >= 0; i--) {
			if(button != allObjects[i]) {
				var event = [button actionsForTarget:allObjects[i] forControlEvent:UIControlEventTouchUpInside];
				events.push(event);
			}
		}
		return events;
	};

	// 递归打印view的层级结构
	GTSubviews = function(view) {
		if(![view isKindOfClass:[UIView class]]) throw new Error(invaldParamStr);
		return view.recursiveDescription().toString();
	};

	// 判断是否为字符串
	GTIsString = function(str) {
		return typeof str == 'string' || str instanceof String;
	};

	// 判断是否为数组
	GTIsArray = function(arr) {
		return arr instanceof Array;
	};

	// 判断是否为数字
	GTIsNumber = function(num) {
		return typeof num == 'number' || num instanceof Number;
	};


	// 通过类名获取类
	_GTClass = function(className) {
		if(!className) throw new Error(missedParamStr);
		if(GTIsString(className)) {
			return NSClassFromString(className);
		}
		if(!className) throw new Error(invaldParamStr);
		return className.class();
	};

	// 打印所有的子类，可选正则
	GTAllSubclasses = function(className, reg) {
		className = _GTClass(className);
		return [c for each (c in ObjectiveC.classes)
			if(c != className 
				&& class_getSuperclass(c) 
				&& [c isSubclassOfClass:className] 
				&& (!reg || reg.test(c)))
		];
	};

	// 打印所有的方法
	var _GTAllMethods = function(className, reg, clazz) {

		className = _GTClass(className);

		var count = new new Type('I')
		var classObj = clazz ? className.constructor : className;
		var methodList = class_copyMethodList(classObj, count);
		var methodsArray = [];
		var methodNamesArray = [];
		for (var i = 0; i < *count; i++) {
			var method = methodList[i];
			var selector = method_getName(method);
			var name = sel_getName(selector);
			if(reg && !reg.test(name)) continue;
			methodsArray.push({
				selector : selector,
				type: method_getTypeEncoding(method)
			});
			methodNamesArray.push(name);
		}
		free(methodList);
		return [methodsArray, methodNamesArray];
	};

	var _GTMethods = function(className, reg, clazz) {
		return _GTAllMethods(className, reg, clazz)[0];
	};

	var _GTMethodsNames = function(className, reg, clazz) {
		return _GTAllMethods(className, reg, clazz)[1];
	};

	// 打印所有的对象方法
	GTInstanceMethods = function(className, reg) {
		return _GTMethods(className, reg);
	};

	// 打印所有的对象方法名字
	GTInstanceMethodsNames = function(className, reg) {
		return _GTMethodsNames(className, reg);
	};

	// 打印所有的类方法
	GTClassMethods = function(className, reg) {
		return _GTMethods(className, reg, true);
	};

	// 打印所有的类方法名字
	GTClassMethodsNames = function(className, reg) {
		return _GTMethodsNames(className, reg, true);
	};

	// 打印所有的成员变量
	GTIvars = function(obj, reg) {
		if(!obj) throw new Error(missedParamStr);
		var x = {};
		for(var i in *obj) {
			try {
				var value = (*obj)[i];
				if(reg && !reg.test(i) && reg.test(value)) continue;
				x[i] = value;

			} catch(e){}
		}
		return x;
	};

	// 打印所有的成员变量名字
	GTIvarsNames = function(obj, reg) {
		if(!obj) throw new Error(missedParamStr);
		var array = [];
		for(var name in *obj) {
			if(reg && !reg.test(name)) continue;
			array.push(name);
		}
		return array;
	};


	// CG方法
	GTPointMake = function(x, y) {
		return {0 : x, 1 : y};
	};

	GTSizeMake = function(w, h) {
		return {0 : w,1 : h};
	}

	GTRectMake = function(x, y, w, h) {
		return {0 : GTPointMake(x, y), 1: GTSizeMake(w, h)};
	};

})(exports);