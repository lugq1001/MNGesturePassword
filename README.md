MNGesturesLock
==============

A GesturesLock View for iOS includes lock&unlock

## Usage

```
#import "ViewController.h"
#import "MNGesturesLockView.h"
#import "MNGesturesLockConfig.h"
#import "MNGesturesLockDelegate.h"

@interface ViewController () <MNGesturesLockDelegate>

@property (nonatomic, strong) MNGesturesLockView *gesturesView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gesturesView = [[MNGesturesLockView alloc] initWithConfig:[MNGesturesLockConfig defaults]];
    self.gesturesView.delegate = self;
    [self.view addSubview:self.gesturesView];
}

- (void)didGesturesPasswordCompleted:(NSString *)gesturePassword
{
    if ([gesturePassword isEqualToString:@"your password"]) {
        // handle logic...
        //....
        //...
    } else {
        [self.gesturesView passwordErrored];
    }
}

@end

```
