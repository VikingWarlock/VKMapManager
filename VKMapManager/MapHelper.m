//
//  MapHelper.m
//  AudioSpeeder
//
//  Created by VKWK on 1/17/16.
//  Copyright © 2016 VKWK. All rights reserved.
//

#import "MapHelper.h"
#import <GoogleMaps/GoogleMaps.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapComponent.h>

@interface MapHelper()<BMKGeneralDelegate>
{
    
    
}

@property(nonatomic,strong)BMKMapManager *bmkManager;

@end

@implementation MapHelper

+(MapHelper *)sharedObject
{
    static id share;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (share==nil) {
            share=[[MapHelper alloc]init];
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
    if ([MapHelper sharedObject].bmkManager==nil) {
        [MapHelper sharedObject].bmkManager=[[BMKMapManager alloc]init];
    }
    [[MapHelper sharedObject].bmkManager start:apikey generalDelegate:[MapHelper sharedObject]];
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
