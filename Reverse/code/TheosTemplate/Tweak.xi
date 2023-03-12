
#import "xctheos.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NewClass.h"

typedef void(^LogTestBlk)(void);
 

@interface SettingsViewController: UIViewController

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, copy) LogTestBlk logTest;

- (void)testXcTheosLogos;
@end


HOOK(SettingsViewController)


- (void)viewDidLoad {
    ORIG();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:Img(@"icon.png")];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    imageView.backgroundColor = UIColor.redColor;
    [self.view addSubview:imageView];
    
    UILabel *sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:sumLabel];

    sumLabel.text = @([NewClass sum:100 add:4]).stringValue;
    
}


END()
