//
//  VKMapManager.m
//  VKMapManager
//
//  Created by VKWK on 1/18/16.
//  Copyright © 2016 VKWK. All rights reserved.
//

#import "VKMapManager.h"
#import <GoogleMaps/GoogleMaps.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapComponent.h>


@interface VKMapManager()<BMKGeneralDelegate>

@property(nonatomic,strong)BMKMapManager *bmkManager;


@end

@implementation VKMapManager



+(VKMapManager *)sharedObject
{
    static id share;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (share==nil) {
            share=[[VKMapManager alloc]init];
        }
    });
    return share;
}

+(BOOL)registerGoogleMapWithAPIKey:(NSString*)apikey
{
    return [GMSServices provideAPIKey:apikey];
}

+(void)registerBaiduMapWithAPIKey:(NSString *)apikey
{
    if ([VKMapManager sharedObject].bmkManager==nil) {
        [VKMapManager sharedObject].bmkManager=[[BMKMapManager alloc]init];
    }
    [[VKMapManager sharedObject].bmkManager start:apikey generalDelegate:[VKMapManager sharedObject]];
}

#pragma Baidu Delegates
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

#pragma Google Delegates


#pragma Application State changed
-(void)WillResignActive
{
    [BMKMapView willBackGround];
}

-(void)DidBecomeActive
{
    [BMKMapView didForeGround];
}

@end
