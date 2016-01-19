##VKMapManager
###There are many map SDKs for developers to use, but in some circumstance we may have to use multipy Map SDKs in a single project.
---
####This project is used to add BaiduMap SDK and GoogleMap SDK to your project with the same and easy API.

---

根据平台返回相应的mapview实例
Return the mapview depending on the platform.

	@property(nonatomic,readonly,nonnull)UIView *mapview;


百度地图的委托方法
MapviewDelegate for BaiduMapSDK

	@property(nonatomic,weak)id<BMKMapViewDelegate>bmkDelegate;

谷歌地图的委托方法
MapviewDelegate for GoogleMapSDK

	@property(nonatomic,weak)id<GMSMapViewDelegate>gmsDelegate;


设置平台,默认百度地图. 
Set the platform,Default is BaiduMap
	
	@property(nonatomic,assign)VKMapPlatform platform;

设置地图类型.
Set the map type.
	
	@property(nonatomic,assign)VKMapType mapType;

设置缩放等级
Set the zoom level.

	@property(nonatomic,assign)float zoomLevel;

设置显示用户位置.
Enable showing user location

	@property(nonatomic,assign)BOOL userLocationEnable;


Register API Key for Google Map SDK

	+(BOOL)registerGoogleMapWithAPIKey:(nullable NSString*)apikey;

注册百度地图SDK
	
	+(void)registerBaiduMapWithAPIKey:(nullable NSString *)apikey;

+(nullable VKMapManager*)sharedObject;


 *添加单个路径点并绘制.Add a point to the path and draw the path.

	-(void)addPoint:(CLLocationCoordinate2D)coordinate andOptions:(nullable NSDictionary*)options;


 *添加多个路径点并绘制.Add points to the path and draw the path.

	-(void)addPoints:(nullable CLLocationCoordinate2D*)coordinates andOptions:(nullable NSDictionary*)options;


####Still developing.....