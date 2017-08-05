//
//  ViewController.m
//  Location_GoogleAPI
//
//  Copyright © 2017 Vyas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) getGoogleAPIKey
{
    NSString *strGoogleAPIKey = GoogleAPI_Key;
    if ([Function string_isEmpty:strGoogleAPIKey] == YES)
        return NO;
    else
        return YES;
}

#pragma mark - Button Action Methods
- (IBAction)btnAutoCompAction
{
    if ([self getGoogleAPIKey] == NO)
    {
        [Function showAlertMessage:MESS_PleaseSetGoogleAPIKey autoHide:NO];
        return;
    }
    
    LocationVC *objVC = loadViewController(@"Main", @"LocationVC");
    objVC.objEnumLocation = enumLocation_AutoComp;
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)btnAutoCompLatLogAction
{
    if ([self getGoogleAPIKey] == NO)
    {
        [Function showAlertMessage:MESS_PleaseSetGoogleAPIKey autoHide:NO];
        return;
    }
    
    LocationVC *objVC = loadViewController(@"Main", @"LocationVC");
    objVC.objEnumLocation = enumLocation_AutoCompLatLog;
    [self.navigationController pushViewController:objVC animated:YES];
}

- (IBAction)btnLatLogAddressAction
{
    if ([self getGoogleAPIKey] == NO)
    {
        [Function showAlertMessage:MESS_PleaseSetGoogleAPIKey autoHide:NO];
        return;
    }
    
    LocationVC *objVC = loadViewController(@"Main", @"LocationVC");
    objVC.objEnumLocation = enumLocation_LatLogAddress;
    [self.navigationController pushViewController:objVC animated:YES];
}
@end
