//
//  LocationVC.h
//  Location_GoogleAPI
//
//  Copyright © 2017 Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Function.h"
#import "WSModel.h"
#import "Constant.h"

#import <MapKit/MapKit.h>

@interface LocationVC : UIViewController
{
    //----------------->
    __weak IBOutlet UIView *viewTitlebar;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIActivityIndicatorView *loader;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UIButton *btnSearch_Or_Dismiss;
    
    //----------------->
    __weak IBOutlet UIView *viewLoading;
    __weak IBOutlet UILabel *lblLoading;
    
    //----------------->
    __weak IBOutlet UIView *viewAddress;
    __weak IBOutlet NSLayoutConstraint *lc_ViewAddress_y;
    __weak IBOutlet UILabel *lblAddress;
    
    //----------------->
    __weak IBOutlet UIView *viewSearch;
    __weak IBOutlet NSLayoutConstraint *lc_viewSearch_x;
    __weak IBOutlet UITextField *txtSearch;
    __weak IBOutlet UITableView *tblLocation;
    
    //----------------->
    __weak IBOutlet UIView *viewMap;
    __weak IBOutlet MKMapView *mapview;
    __weak IBOutlet UIView *viewMapAddress;
    
    __weak IBOutlet UILabel *lblMapAddress;
}
@property enum enumLocation objEnumLocation;

- (IBAction)btnBackAction;
- (IBAction)btnSearch_Or_DismissAction;

@end
