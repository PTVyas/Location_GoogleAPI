//
//  ViewController.h
//  Location_GoogleAPI
//
//  Copyright © 2017 Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LocationVC.h"
#import "Constant.h"

@interface ViewController : UIViewController
{
    __weak IBOutlet UIButton *btnAutoComp;
    __weak IBOutlet UIButton *btnAutoCompLatLog;
    __weak IBOutlet UIButton *btnLatLogAddress;
}

- (IBAction)btnAutoCompAction;
- (IBAction)btnAutoCompLatLogAction;
- (IBAction)btnLatLogAddressAction;

@end
