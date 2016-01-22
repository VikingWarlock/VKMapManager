//
//  VKMapManager.h
//  VKMapManager
//
//  Created by VKWK on 1/18/16.
//  Copyright © 2016 VKWK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VKPath.h"


typedef NS_ENUM(NSInteger,VKMapPlatform) {
    VKMapPlatform_Baidu=0,
    VKMapPlatform_Google=1,
    VKMapPlatform_Other=2
};

typedef NS_ENUM(NSInteger,VKMapType)
{
    VKMapType_Normal=0,
    VKMapType_Satellite=1
};

@protocol BMKMapViewDelegate;
@protocol GMSMapViewDelegate;

@protocol VKMapDelegate <NSObject>

@optional


@end


@interface VKMapManager : NSObject

/**
 *Will return the mapview depending on the platform.
 *会根据平台返回相应的mapview实例
 */
@property(nonatomic,readonly,nonnull)UIView *mapview;

@property(nonatomic,weak)id<VKMapDelegate> delegate;

/**
 *百度地图的委托方法,MapviewDelegate for BaiduMapSDK
 */
@property(nonatomic,weak)id<BMKMapViewDelegate>bmkDelegate;
@property(nonatomic,weak)id<GMSMapViewDelegate>gmsDelegate;


/**
 *设置平台,默认百度地图. Set the platform,Default is BaiduMap
 */
@property(nonatomic,assign)VKMapPlatform platform;

/**
 *设置地图类型.Set the map type.
 */
@property(nonatomic,assign)VKMapType mapType;

/**
 *设置缩放等级,Set the zoom level.
 */
@property(nonatomic,assign)float zoomLevel;

/**
 *设置显示用户位置.Enable showing user location
 */
@property(nonatomic,assign)BOOL userLocationEnable;

/**
 *Register API Key for Google Map SDK
 */
+(BOOL)registerGoogleMapWithAPIKey:(nullable NSString*)apikey;

/**
 *注册百度地图SDK
 */
+(void)registerBaiduMapWithAPIKey:(nullable NSString *)apikey;

/**
 *返回单例
 */
+(nullable VKMapManager*)sharedObject;

-(nullable instancetype)init NS_UNAVAILABLE;

/**
 *添加单个路径点并绘制.Add a point to the path and draw the path.
 */
-(void)addPoint:(CLLocationCoordinate2D)coordinate andOptions:(nullable NSDictionary*)options;
-(void)addPoint:(CLLocation*)location;


/**
 *添加多个路径点并绘制.Add points to the path and draw the path.
 */
-(void)addPoints:(nullable CLLocationCoordinate2D*)coordinates andOptions:(nullable NSDictionary*)options;

/**
 *添加多条路径.Add pathes to the map
 */
-(void)addLine:(nonnull NSArray*)points andOptions:(nullable NSDictionary*)options;


@end
