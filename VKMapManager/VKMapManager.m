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


@interface VKMapManager()<BMKGeneralDelegate,GMSMapViewDelegate,BMKMapViewDelegate>
{
    CLLocationCoordinate2D *locationList;
    GMSPath *googlePath;
    BMKPolyline *baiduPath;
    GMSMapView *googleMap;
    BMKMapView *baiduMap;

}
@property(nonatomic,strong)BMKMapManager *bmkManager;


@end

@implementation VKMapManager



+(VKMapManager *)sharedObject
{
    static id share;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (share==nil) {
            share=[[VKMapManager alloc]initWithNotification];
        }
    });
    return share;
}

-(instancetype)initWithNotification
{
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;

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
- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{

}


- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{


}
- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{

}
- (void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{

}

- (void)mapView:(GMSMapView *)mapView
didLongPressInfoWindowOfMarker:(GMSMarker *)marker{

}
- (void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay
{

}

- (void)mapView:(GMSMapView *)mapView didCloseInfoWindowOfMarker:(GMSMarker *)marker
{

}
- (void)mapView:(GMSMapView *)mapView didBeginDraggingMarker:(GMSMarker *)marker
{

}
- (void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker
{

}
- (void)mapView:(GMSMapView *)mapView didDragMarker:(GMSMarker *)marker
{

}

- (BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView
{
    if (self.gmsDelegate) {
        if ([self.gmsDelegate respondsToSelector:@selector(didTapMyLocationButtonForMapView:)]) {
            return [self.gmsDelegate didTapMyLocationButtonForMapView:mapView];
        }
    }
    return NO;
}

- (void)mapViewDidStartTileRendering:(GMSMapView *)mapView;
{
    if (self.gmsDelegate) {
        if ([self.gmsDelegate respondsToSelector:@selector(mapViewDidStartTileRendering:)]) {
            [self.gmsDelegate mapViewDidStartTileRendering:mapView];
        }
    }
}

- (void)mapViewDidFinishTileRendering:(GMSMapView *)mapView
{
    if (self.gmsDelegate) {
        if ([self.gmsDelegate respondsToSelector:@selector(mapViewDidFinishTileRendering:)]) {
            [self.gmsDelegate mapViewDidFinishTileRendering:mapView];
        }
    }
}

#pragma Baidu Delegates


#pragma Application State changed
-(void)WillResignActive
{
    [BMKMapView willBackGround];
}

-(void)DidBecomeActive
{
    [BMKMapView didForeGround];
}


#pragma Public Method
-(void)addPoint:(CLLocationCoordinate2D)coordinate andOptions:(NSDictionary *)options
{

}


-(void)addPoints:(CLLocationCoordinate2D *)coordinates andOptions:(NSDictionary *)options
{

}


-(void)addLine:(NSArray *)points andOptions:(NSDictionary *)options
{

}

-(void)setPlatform:(VKMapPlatform)platform
{
    switch (platform) {
        case VKMapPlatform_Google:
        {
            if (googleMap==nil) {
                googleMap=[[GMSMapView alloc]init];
                googleMap.delegate=self;
            }
            if (baiduMap) {
                baiduMap.delegate=nil;
                baiduMap=nil;
            }
            break;
        }
        case VKMapPlatform_Baidu:
        {
            if (googleMap) {
                googleMap.delegate=self;
                googleMap=nil;
            }
            if (baiduMap==nil) {
                baiduMap=[[BMKMapView alloc]init];
                baiduMap.delegate=self;
            }

            break;
        }
        default:
            break;
    }
}




@end
