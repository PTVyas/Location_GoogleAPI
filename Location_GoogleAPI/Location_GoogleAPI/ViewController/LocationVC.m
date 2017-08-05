//
//  LocationVC.m
//  Location_GoogleAPI
//
//  Copyright © 2017 Vyas. All rights reserved.
//

#import "LocationVC.h"

@interface LocationVC () <UITextFieldDelegate,MKMapViewDelegate>
{
    NSMutableArray *arrLocationList;
    NSMutableDictionary *dicLocationInfo;
    
    CLLocation *location;
}@end

@implementation LocationVC
@synthesize objEnumLocation;

- (void)viewDidLoad
{
    //-------------------------------->
    arrLocationList = [[NSMutableArray alloc] init];
    dicLocationInfo = [[NSMutableDictionary alloc] init];

    [self manage_View];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) manage_View
{
    NSString *strTitle = @"";
    strTitle = [@"Location" uppercaseString];
    
    viewLoading.hidden = YES;
    viewAddress.hidden = YES;
    viewSearch.hidden = YES;
    viewMap.hidden = YES;
    
    //------------------------------>
    //View-Serach Place
    tblLocation.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tblLocation.backgroundColor = [UIColor lightGrayColor];
    tblLocation.layer.cornerRadius = 5;
    tblLocation.layer.masksToBounds = YES;
    
    //Textfiled - Searchbar
    txtSearch.delegate = self;
    txtSearch.backgroundColor = [UIColor whiteColor];
    txtSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtSearch.placeholder = @"Search";
    [txtSearch addTarget:self action:@selector(myTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //-------------------------------->
    //Loading-View
    viewLoading.layer.cornerRadius = 5;
    viewLoading.layer.borderColor = [UIColor whiteColor].CGColor;
    viewLoading.layer.borderWidth = 1.0f;
    viewLoading.layer.masksToBounds = YES;
    
    lblLoading.text = @"Loading...";
    lblLoading.numberOfLines = 0;
    
    [self manage_loader_GeetingAddress_isShow:NO];
    
    //-------------------------------->
    //Address-View
    viewAddress.layer.cornerRadius = 5;
    viewAddress.layer.borderColor = [UIColor whiteColor].CGColor;
    viewAddress.layer.borderWidth = 1.0f;
    viewAddress.layer.masksToBounds = YES;
    
    lblAddress.text = @"";
    lblAddress.numberOfLines = 0;
    
    [self manage_Animation_AddressView_Show:NO];
    
    //-------------------------------->
    //Map-View
    mapview.showsUserLocation = YES;
    
    mapview.layer.cornerRadius = 5;
    mapview.layer.borderColor = [UIColor whiteColor].CGColor;
    mapview.layer.borderWidth = 1.0f;
    mapview.layer.masksToBounds = YES;
    
    viewMapAddress.layer.cornerRadius = 5;
    viewMapAddress.layer.borderColor = [UIColor whiteColor].CGColor;
    viewMapAddress.layer.borderWidth = 1.0f;
    viewMapAddress.layer.masksToBounds = YES;
    
    lblMapAddress.text = @"Getting Address...";
    lblMapAddress.numberOfLines = 0;
    
    //-------------------------------->
    //-------------------------------->
    if (objEnumLocation == enumLocation_AutoComp)
    {
        strTitle = [NSString stringWithFormat:@"%@\n(Auto Comple)",strTitle];
        btnSearch_Or_Dismiss.hidden = YES;
        
        viewSearch.hidden = NO;
        [self manage_SearchPlace:YES];
    }
    else if (objEnumLocation == enumLocation_AutoCompLatLog)
    {
        strTitle = [NSString stringWithFormat:@"%@\n(Auto Comple + Lat-Log Value)",strTitle];
        
        viewSearch.hidden = NO;
        [self manage_SearchPlace:YES];
        
        viewAddress.hidden = NO;
    }
    else if (objEnumLocation == enumLocation_LatLogAddress)
    {
        strTitle = [NSString stringWithFormat:@"%@\n(Lat-Log Values Google Address)",strTitle];
        btnSearch_Or_Dismiss.hidden = YES;
        
        viewMap.hidden = NO;
        
        location = [[CLLocation alloc] initWithLatitude:mapview.centerCoordinate.latitude longitude:mapview.centerCoordinate.longitude];
        [self calledWebService_On_GetLocationInfo];
    }
    
    //------------------------------>
    //Title
    lblTitle.text = strTitle;
    lblTitle.numberOfLines = 2;
    [self loaderOnTitlebar_isShow:NO];
}


-(void) loaderOnTitlebar_isShow:(BOOL)isShow
{
    loader.hidden = YES;
    //btnDismiss.hidden = YES;
    
    if (isShow == YES) {
        loader.hidden = NO;
        [loader startAnimating];
    }
}

- (void) manage_SearchPlace:(BOOL)searchPlace
{
    if (searchPlace == YES)
    {
        viewSearch.hidden = NO;
        
        //viewSearch.backgroundColor = [UIColor lightGrayColor];
        [UIView animateWithDuration:durationAnimation
                         animations:^{
                             lc_viewSearch_x.constant = 0;
                             [self.view layoutIfNeeded];
                             [tblLocation reloadData];
                         } completion:^(BOOL finished)
         {
             [btnSearch_Or_Dismiss setImage:img_Map_Cancel forState:UIControlStateNormal];
             [txtSearch becomeFirstResponder];
         }];
    }
    else
    {
        [txtSearch resignFirstResponder];
        [self.view endEditing:YES];
        
        //viewSearch.backgroundColor = [UIColor lightGrayColor];
        [UIView animateWithDuration:durationAnimation
                         animations:^{
                             //lc_viewSearch_x.constant = 0;
                             lc_viewSearch_x.constant = self.view.frame.size.width;
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished)
         {
             [btnSearch_Or_Dismiss setImage:img_Map_Search forState:UIControlStateNormal];
             viewSearch.hidden = YES;
             
         }];
    }
}

- (void) manage_loader_GeetingAddress_isShow:(BOOL)isShow
{
    viewLoading.hidden = YES;
    
    if (isShow == YES) {
        viewLoading.hidden = NO;
    }
}

- (void) manage_Animation_AddressView_Show:(BOOL)show
{
    if (show == NO)
    {
        //Hide Button With Animation
        [UIView animateWithDuration:0.30f
                         animations:^{
                             lc_ViewAddress_y.constant = -(30 + viewAddress.frame.size.height);
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished)
         {
             //Code
         }];
    }
    else
    {
        if (dicLocationInfo.count == 0)
        {
            [self manage_Animation_AddressView_Show:NO];
            return;
        }
        
        viewAddress.hidden = NO;
        
        //Set Button Title
        //NSString *strAddress = [NSString stringWithFormat:@"%@",[dicLocationInfo valueForKeyPath:_keyAddress]];
        //lblAddress.text = strAddress;
        lblAddress.numberOfLines = 0;
        
        //Show Button With Animation
        [UIView animateWithDuration:0.30f
                         animations:^{
                             lc_ViewAddress_y.constant = 30;
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished)
         {
             //Code
         }];
    }
}

#pragma mark - TextField (Search) Delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self myTextFieldDidChange:textField];
}

-(void)myTextFieldDidChange:(UITextField*)textField
{
    NSString *strValue = [Function trimmingString:textField.text];
    if([Function string_isEmpty:strValue] == YES)
    {
    }
    else
    {
        [self calledWebService_On_Text:strValue];
    }
    //[tblLocation reloadData];
}

#pragma mark - Called Web Service
- (void) calledWebService_On_Text:(NSString *)strValue {
    [self loaderOnTitlebar_isShow:YES];
    
    NSString *strUrl = @"";
    NSString *strKey = [Function trimmingString:strValue];
    
    if ([Function reachabilityCheck] == NO) {
        [Function showAlertMessage:MESS_CheckInternetConnction autoHide:YES];
        return;
    }
    
    
    strUrl = GoogleAutoCompletWS(GoogleAPI_Key, strKey);
    //strUrl = [Function urlEncode:strUrl];
    strUrl = [Function replaceString:strUrl replaceValue:@" " withString:@"%20"];
    
    [WSModel CalledWebService:strUrl
                        mehod:@"POST"
                   parameters:[NSMutableDictionary new]
                      headers:[NSMutableDictionary new]
                 responseData:^(NSDictionary *dic, NSError *error)
     {
         //NSLog(@"GoogleAutoCompletWS dic: %@",dic);
         //NSLog(@"GoogleAutoCompletWS error: %@",error);
         
         if (error != Nil) {
         }
         else
         {
             arrLocationList = [[NSMutableArray alloc] init];
             
             NSMutableArray *arrPlaceData = [dic valueForKey:@"predictions"];
             for (NSMutableDictionary *dicValue in arrPlaceData)
             {
                 NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                 NSString *strPlaceID = [dicValue valueForKey:@"place_id"];
                 NSString *strPlace = [dicValue valueForKey:@"description"];
                 
                 [dic setValue:strPlaceID forKey:_keyPlaceID];
                 [dic setValue:strPlace forKey:_keyPlaceName];
                 [arrLocationList addObject:dic];
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             [self loaderOnTitlebar_isShow:NO];
             tblLocation.hidden = NO;
             [tblLocation reloadData];
         });
     }];
}

- (void) calledWebService_On_GetLocationLatLogInfo:(NSString *)strPlaceID
{
    NSString *strUrl = GooglePlaceLatLogWS(GoogleAPI_Key, strPlaceID);
    //strUrl = [Function urlEncode:strUrl];
    
    [WSModel CalledWebService:strUrl
                        mehod:@"POST"
                   parameters:[NSMutableDictionary new]
                      headers:[NSMutableDictionary new]
                 responseData:^(NSDictionary *dic, NSError *error)
     {
         //NSLog(@"GoogleAutoCompletWS dic: %@",dic);
         //NSLog(@"GoogleAutoCompletWS error: %@",error);
         
         if (error != Nil)
         {
             lblAddress.text = @"Unable to get Address Information.";
             [self manage_Animation_AddressView_Show:YES]; //Show Address
         }
         else
         {
             NSMutableDictionary *placeInfo = [[NSMutableDictionary alloc] init];
             placeInfo = [dic valueForKey:@"result"];
             NSLog(@"placeInfo: %@",placeInfo);
             
             //Get Location Lat.-Long.
             NSMutableDictionary *dicLocation = [placeInfo valueForKeyPath:@"geometry.location"];
             //print(dicLocation);
             double lati = [[dicLocation valueForKey:@"lat"] doubleValue];
             double longi = [[dicLocation valueForKey:@"lng"] doubleValue];
             
             NSString *Address = @"";
             NSString *City = @"";
             NSString *ZipCode = @"";
             NSString *State = @"";
             NSString *Country = @"";
             NSString *Latitude = @"";
             NSString *Longitude = @"";
             
             Address = [Function keyExisteOnDictionary:placeInfo key:@"formatted_address"];
             City = [Function keyExisteOnDictionary:placeInfo key:@" "];
             ZipCode = [Function keyExisteOnDictionary:placeInfo key:@" "];
             State = [Function keyExisteOnDictionary:placeInfo key:@" "];
             Country = [Function keyExisteOnDictionary:placeInfo key:@" "];
             Latitude = [NSString stringWithFormat:@"%f",lati];
             Longitude = [NSString stringWithFormat:@"%f",longi];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 //btnSearch_Or_Dismiss.hidden = YES;
                 //txtSearch.text = Address;
                 tblLocation.hidden = YES;
                 
                 dicLocationInfo = [[NSMutableDictionary alloc] init];
                 [dicLocationInfo setValue:Address forKey:_keyAddress];
                 [dicLocationInfo setValue:City forKey:_keyCity];
                 [dicLocationInfo setValue:ZipCode forKey:_keyZip];
                 [dicLocationInfo setValue:State forKey:_keyState];
                 [dicLocationInfo setValue:Country forKey:_keyCountry];
                 [dicLocationInfo setValue:Latitude forKey:_keyLatitude];
                 [dicLocationInfo setValue:Longitude forKey:_keyLongitude];
                 
                 NSString *strPlace = [dicLocationInfo valueForKey:_keyPlaceName];
                 strPlace = Address;
                 strPlace = [NSString stringWithFormat:@"Lat-Log: %@,%@\nAdd.: %@",Latitude,Longitude, Address];
                 lblAddress.text = [Function trimmingString:strPlace];
                 
                 [self manage_Animation_AddressView_Show:YES]; //Show Address
             });
         }
         [self loaderOnTitlebar_isShow:NO];
     }];
}

- (void) calledWebService_On_GetLocationInfo
{
    NSString *strLatitude = @"";
    NSString *strLongitude = @"";
    strLatitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    strLongitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString *strUrl = GooglePlaceInfoWS(strLatitude, strLongitude, GoogleAPI_Key);
    
    [WSModel CalledWebService:strUrl
                        mehod:@"POST"
                   parameters:[NSMutableDictionary new]
                      headers:[NSMutableDictionary new]
                 responseData:^(NSDictionary *dic, NSError *error)
     {
         NSLog(@"GooglePlaceInfoWS dic: %@",dic);
         NSLog(@"GooglePlaceInfoWS error: %@",error);
         
         [self loaderOnTitlebar_isShow:NO];
         
         if (error != Nil)
         {
             lblMapAddress.text = @"Unable to get Address";
         }
         else
         {
             NSMutableArray *placeList = [[NSMutableArray alloc] init];
             placeList = [dic valueForKey:@"results"];
             if (placeList.count == 0)
             {
                 lblMapAddress.text = @"Unable to get Address";
             }
             else
             {
                 NSMutableDictionary *placeInfo = [[NSMutableDictionary alloc] init];
                 placeInfo = [placeList firstObject];
                 NSLog(@"placeInfo: %@",placeInfo);
                 
                 NSString *Address = @"";
                 Address = [Function keyExisteOnDictionary:placeInfo key:@"formatted_address"];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSString *strPlace = @"";
                     strPlace = Address;
                     strPlace = [NSString stringWithFormat:@"Lat-Log: %@,%@\nAdd.: %@",strLatitude,strLongitude, Address];
                     lblMapAddress.text = [Function trimmingString:strPlace];
                 });
             }
         }
         [self loaderOnTitlebar_isShow:NO];
     }];
}


#pragma mark - Button Action Methods
- (IBAction)btnBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSearch_Or_DismissAction
{
    [self.view endEditing:YES];
    
    if (lc_viewSearch_x.constant == 0)
    {
        [self manage_SearchPlace:NO];
    }
    else
    {
        [self manage_SearchPlace:YES];
    }
}

#pragma mark - Tableview Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int noOfRow = 0;
    noOfRow = (int)arrLocationList.count;
    //noOfRow = 0;
    
    if (noOfRow == 0) {
        NSString *Mess = [MESS_NoDataFound uppercaseString];
        [Function setPlaceholder_OnTableView:tblLocation PlaceHolderText:Mess image:nil];
    }
    else {
        //tableView.backgroundView = [[UIView alloc] init];
    }
    return noOfRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Hide Loader
    [self loaderOnTitlebar_isShow:NO];
    tblLocation.hidden = NO;
    
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *strLocation = @"";
    NSString *strCountry = @"";
    
    if (arrLocationList.count == 0) {
        return cell;
    }
    
    dic = [arrLocationList objectAtIndex:indexPath.row];
    strLocation = [dic valueForKey:_keyPlaceName];
    strCountry = @"";
    
    cell.imageView.image = [UIImage imageNamed:@"icon_DropLocation"];
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height/2;
    cell.imageView.layer.masksToBounds = YES;
    
    cell.textLabel.text = strLocation;
    [Function setLabelDesign_label:cell.textLabel text:strLocation textColor:[UIColor blackColor] font:Font_Helvetica fontSize:16];
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text =strCountry;
    [Function setLabelDesign_label:cell.detailTextLabel text:strCountry textColor:[UIColor lightGrayColor] font:Font_Helvetica fontSize:10];
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    tableView.separatorColor = [UIColor blackColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    if (objEnumLocation == enumLocation_AutoComp)
    {
        return;
    }
    
    dicLocationInfo = [[NSMutableDictionary alloc] init];
    NSString *strPlaceID = [[arrLocationList objectAtIndex:indexPath.row] objectForKey:_keyPlaceID];
    [self calledWebService_On_GetLocationLatLogInfo:strPlaceID];
    
    /*
     NSString *strPlace = [[arrLocationList objectAtIndex:indexPath.row] objectForKey:_keyPlaceName];
     lblAddress.text = [Function trimmingString:strPlace];
     //[self manage_Animation_AddressView_Show:YES]; //Show Address
     */
    
    [self btnSearch_Or_DismissAction]; //Dismis Search
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - MapView
#pragma mark MapView Delegate related method
-(void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //return;
    //NSLog(@"%f %f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    
    CLLocation *locationCenter = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    if (locationCenter == location) {
        NSLog(@"same Location");
        return;
    }
    
    lblMapAddress.text = @"";
    dicLocationInfo = [[NSMutableDictionary alloc] init];
    [self loaderOnTitlebar_isShow:YES];
    
    location = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    [self calledWebService_On_GetLocationInfo];
}

@end
