//
//  VKPath.h
//  VKMapManager
//
//  Created by VKWK on 1/19/16.
//  Copyright © 2016 VKWK. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@class GMSPath;
@class BMKPolyline;

@interface VKPath : NSObject

@property(nonatomic,readonly)NSUInteger count;

/**
 *获取百度路径
 */
@property(nonatomic,readonly)BMKPolyline *baiduPath;

/**
 *Fetch Google Path
 */
@property(nonatomic,readonly)GMSPath *googlePath;

-(void)addPoint:(CLLocationCoordinate2D)loaction;

-(void)getLocationArray:(CLLocationCoordinate2D*)locations;


@end
