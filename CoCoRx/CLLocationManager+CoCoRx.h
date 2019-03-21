//
//  CLLocationManager+CoCoRx.h
//  CoCoRx
//
//  Created by iScarlett CoCo on 2019/3/20.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <ReactiveObjC/ReactiveObjC.h>

#ifdef __CORELOCATION__

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CLAuthorizationModelWhenInUse, // 用户使用时
    CLAuthorizationModelAlways,    // 总是使用定位
} CLAuthorizationModel;

@interface CLLocationManager (CoCoRx)

/*
 授权请求模式,默认为 WhenInUse
 */
@property (nonatomic, assign) CLAuthorizationModel authorizationModel;


/*
 返回kCLAuthorizationStatusAuthorizedWhenInUse 表示已授权同意
 返回kCLAuthorizationStatusNotDetermined 表示还没有确认过,等待确认
 返回kCLAuthorizationStatusDenied 表示授权已被拒绝
 */
- (RACSignal *)requestAuthorizationSignal;



/*
 获取定位坐标,获取一次成功后即断开,不重复获取
 内部已包含 请求权限的逻辑,可以直接使用此方法
 注意订阅error
 */
- (RACSignal *)requestCoreLocation;

@end

NS_ASSUME_NONNULL_END

#endif
