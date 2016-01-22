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
#import "VKPath.h"
#import "VKPoint.h"

@interface VKMapManager()<BMKGeneralDelegate,GMSMapViewDelegate,BMKMapViewDelegate>
{
    CLLocationCoordinate2D *locationList;
    GMSPath *googlePath;
    BMKPolyline *baiduPath;
    GMSMapView *googleMap;
    BMKMapView *baiduMap;
    VKPath *path;
    NSMutableArray *PointArray;
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
    if (self.gmsDelegate) {
        if ([self.gmsDelegate respondsToSelector:@selector(mapView:didTapAtCoordinate:)]) {
            [self.gmsDelegate mapView:mapView didTapAtCoordinate:coordinate];
        }
    }else
    {
    
    }

}
- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didLongPressAtCoordinate:)]) {
        [self.gmsDelegate mapView:mapView didLongPressAtCoordinate:coordinate];
    }else
    {
    
    }
}
- (void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didTapInfoWindowOfMarker:)]) {
        [self.gmsDelegate mapView:mapView didTapInfoWindowOfMarker:marker];
    }else
    {
        
    }

}

- (void)mapView:(GMSMapView *)mapView
didLongPressInfoWindowOfMarker:(GMSMarker *)marker{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didLongPressInfoWindowOfMarker:)]) {
        [self.gmsDelegate mapView:mapView didLongPressInfoWindowOfMarker:marker];
    }else
    {
        
    }

}
- (void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay
{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didTapOverlay:)]) {
        [self.gmsDelegate mapView:mapView didTapOverlay:overlay];
    }else
    {
        
    }

}

- (void)mapView:(GMSMapView *)mapView didCloseInfoWindowOfMarker:(GMSMarker *)marker
{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didCloseInfoWindowOfMarker:)]) {
        [self.gmsDelegate mapView:mapView didCloseInfoWindowOfMarker:marker];
    }else
    {
        
    }

}
- (void)mapView:(GMSMapView *)mapView didBeginDraggingMarker:(GMSMarker *)marker
{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didBeginDraggingMarker:)]) {
        [self.gmsDelegate mapView:mapView didBeginDraggingMarker:marker];
    }else
    {
        
    }

}
- (void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker
{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didEndDraggingMarker:)]) {
        [self.gmsDelegate mapView:mapView didEndDraggingMarker:marker];
    }else
    {
        
    }

}
- (void)mapView:(GMSMapView *)mapView didDragMarker:(GMSMarker *)marker
{
    if (self.gmsDelegate&&[self.gmsDelegate respondsToSelector:@selector(mapView:didDragMarker:)]) {
        [self.gmsDelegate mapView:mapView didDragMarker:marker];
    }else
    {
        
    }

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
    [baiduMap addOverlay:nil];
}

-(void)addPoint:(CLLocation *)location
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

-(void)setMapType:(VKMapType)mapType
{
    switch (mapType) {
        case VKMapType_Normal:
        {
            if (googleMap) {
                googleMap.mapType=kGMSTypeNormal;
            }else if (baiduMap){
                baiduMap.mapType=BMKMapTypeStandard;
            }
            break;
        }
        case VKMapType_Satellite:
        {
            if (googleMap) {
                googleMap.mapType=kGMSTypeSatellite;
            }else if (baiduMap){
                baiduMap.mapType=BMKMapTypeSatellite;
            }
            break;
        }
        default:
            break;
    }
}

-(void)setZoomLevel:(float)zoomLevel
{
    if (googleMap) {
        float level=zoomLevel;
        if (zoomLevel<googleMap.minZoom) {
            level=googleMap.minZoom;
        }
        if (zoomLevel>googleMap.maxZoom) {
            level=googleMap.maxZoom;
        }
        [googleMap animateToZoom:level];
    }else if(baiduMap)
    {
        if (zoomLevel<3) {
            zoomLevel=3;
        }
        if (zoomLevel>20) {
            zoomLevel=20;
        }
        [baiduMap setZoomLevel:zoomLevel];
    }
}

-(void)setUserLocationEnable:(BOOL)userLocationEnable
{

    if (googleMap) {
        googleMap.myLocationEnabled=userLocationEnable;
    }
    if (baiduMap) {
        baiduMap.showsUserLocation=userLocationEnable;
    }
}

/**
 *变态的百度地图SDK,这么多 F**king 代理方法
 */
-(void)setBmkDelegate:(id<BMKMapViewDelegate>)bmkDelegate
{
    if (bmkDelegate!=nil) {
        if (baiduMap) {
            baiduMap.delegate=bmkDelegate;
        }
    }else
    {
        baiduMap.delegate=self;
    }
}

@end
