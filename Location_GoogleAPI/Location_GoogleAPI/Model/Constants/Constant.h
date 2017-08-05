//
//  Constant.h
//
//  Copyright © 2017 WOS. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define AppName                                             [NSString stringWithFormat:@"LOCATION\n(Google API)"]

#define GoogleAPI_Key                                       @""
#define GoogleAutoCompletWS(GoogleAPI_Key, strValue)        [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",GoogleAPI_Key,strValue]
#define _keyPlaceID                                         @"_KeyPlaceID"
#define _keyPlaceName                                       @"_KeyPlaceName"
#define GooglePlaceLatLogWS(GoogleAPI_Key, strPlaceID)      [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",strPlaceID,GoogleAPI_Key]

#define GooglePlaceInfoWS(Lat,Long,GoogleAPI_Key)          [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&key=%@",Lat,Long,GoogleAPI_Key]

#define img_Map_Search              [UIImage imageNamed:[NSString stringWithFormat:@"mapSearch"]]
#define img_Map_Cancel              [UIImage imageNamed:[NSString stringWithFormat:@"cancel"]]

#define durationAnimation           0.30f

#define _keyAddress                         @"Address"
#define _keyCity                            @"City"
#define _keyZip                             @"Zip"
#define _keyState                           @"State"
#define _keyCountry                         @"Country"
#define _keyLatitude                        @"Latitude"
#define _keyLongitude                       @"Longitude"

#pragma mark - Storybord
#define loadViewController(storybord, identifier)   [[UIStoryboard storyboardWithName:storybord bundle: nil] instantiateViewControllerWithIdentifier:identifier]

#define stringValue(value)                  [NSString stringWithFormat:@"%@",value]
#define print(value)                        NSLog(@"%@",stringValue(value))

#pragma mark -
#define ShowNetworkIndicator(BOOL)          [UIApplication sharedApplication].networkActivityIndicatorVisible = BOOL
#pragma mark - Font
#define Font(fontName, fontSize)            [UIFont fontWithName:fontName size:fontSize]
// Font
#define Font_Helvetica                      @"Helvetica"
#define FONT_Helvetica(Size)                [UIFont fontWithName:@"Helvetica" size:Size]
#define FONT_Helvetica_Bold(Size)           [UIFont fontWithName:@"Helvetica" size:Size]
#define FONT_Helvetica_Light(Size)          [UIFont fontWithName:@"Helvetica" size:Size]

#pragma mark Message
#define MESS_NoDataFound                    @"No data found"
#define MESS_NoDataAvailable                @"No data available"
#define MESS_CheckInternetConnction                     @"Please Check Internet Connection"
#define MESS_PleaseSetGoogleAPIKey          @"Please set the Google provided API key."


enum enumLocation {
    enumLocation_None = 0,
    enumLocation_AutoComp,
    enumLocation_AutoCompLatLog,
    enumLocation_LatLogAddress
};

#endif /* Constant_h */
