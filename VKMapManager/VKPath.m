//
//  VKPath.m
//  VKMapManager
//
//  Created by VKWK on 1/19/16.
//  Copyright © 2016 VKWK. All rights reserved.
//

#import "VKPath.h"
#import "VKPoint.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
@import GoogleMaps;


@interface VKPath()
{
    NSMutableArray *array;
}
@end

@implementation VKPath

- (instancetype)init
{
    self = [super init];
    if (self) {
        array=[NSMutableArray array];
    }
    return self;
}

-(NSUInteger)count
{
    return array.count;
}

-(void)getLocationArray:(CLLocationCoordinate2D *)locations
{
    for (int i = 0;  i<array.count; i++) {
        VKPoint *point=array[i];
        locations[i]=CLLocationCoordinate2DMake(point.lat, point.lat);
    }
}

-(BMKPolyline*)baiduPath
{
    CLLocationCoordinate2D* list= calloc(array.count, sizeof(CLLocationCoordinate2D));
    
    BMKConvertBaiduCoorFrom(<#CLLocationCoordinate2D coordinate#>, <#BMK_COORD_TYPE type#>)
}

-(GMSPath *)googlePath
{
    GMSMutablePath *path=[GMSMutablePath new];
    for(VKPoint *point in array)
    {
        [path addLatitude:point.lat longitude:point.lon];
    }
    return path;
}

@end
