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

@protocol VKMapDelegate <NSObject>

@optional


@end


@interface VKMapManager : NSObject

@property(nonatomic,readonly,nonnull)UIView *mapview;

@property(nonatomic,weak)id<VKMapDelegate> delegate;



+(BOOL)registerGoogleMapWithAPIKey:(nullable NSString*)apikey;
+(void)registerBaiduMapWithAPIKey:(nullable NSString *)apikey;

+(nullable VKMapManager*)sharedObject;

-(void)addPoint:(CLLocationCoordinate2D)coordinate andOptions:(nullable NSDictionary*)options;

-(void)addLines:(nonnull NSArray*)points andOptions:(nullable NSDictionary*)options;

@end
