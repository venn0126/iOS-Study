//
//  ViewController.m
//  TestFishhook
//
//  Created by Augus on 2021/8/21.
//

#import "ViewController.h"
#import "fishhook.h"

#import <dlfcn.h>
#import <mach-o/loader.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    
}


- (void)testAnimationFromPoint {
    
    
}


- (void)testFishHook {
    
    
    NSLog(@"hhhh");

    
    // rebinding struct
    struct rebinding nslog;
    
    // Need rebinding string of C
    nslog.name = "NSLog";
    
    // Make system function for point to symbol,rebinding custom function in runtime
    nslog.replacement = nwLog;
    
    // Make system function real memory address assgin custom's function pointer
    nslog.replaced = (void*)&sys_nslog;
    
    //
    struct rebinding rebs[1] = {nslog};
    
    // args1 rebindings[] : storage struct of rebinding array
    // args2 rebindings_nel : arrat length
    // int rebind_symbols(struct rebinding rebindings[], size_t rebindings_nel)
    //
    rebind_symbols(rebs, 1);
    
    
    
    self.view.backgroundColor = UIColor.linkColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touch begin screen");
}


// Custom function pointer
void(*sys_nslog)(NSString *format,...);
// Custom function of C
void nwLog(NSString *format,...) {
    
    format = [format stringByAppendingString:@" [rebinding log...]"];
    // Call system function
    sys_nslog(format);
}



@end
