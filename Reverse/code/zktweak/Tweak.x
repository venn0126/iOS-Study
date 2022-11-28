#import "GDTMaskViewController.h"


%hook GDTMaskViewController

- (void)viewDidLoad {

	[self dismissViewControllerAnimated:YES completion:nil];
}

%end

