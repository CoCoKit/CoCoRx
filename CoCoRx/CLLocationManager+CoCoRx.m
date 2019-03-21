//
//  CLLocationManager+CoCoRx.m
//  CoCoRx
//
//  Created by iScarlett CoCo on 2019/3/20.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import "CLLocationManager+CoCoRx.h"

#ifdef __CORELOCATION__
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>

static const void *kCLAuthorizationModel = &kCLAuthorizationModel;

@implementation CLLocationManager (CoCoRx)

- (void)setAuthorizationModel:(CLAuthorizationModel)authorizationModel {
    objc_setAssociatedObject(self, kCLAuthorizationModel, @(authorizationModel), OBJC_ASSOCIATION_ASSIGN);
}

- (CLAuthorizationModel)authorizationModel {
    return [objc_getAssociatedObject(self, kCLAuthorizationModel) unsignedIntegerValue];
}

/*
 返回kCLAuthorizationStatusAuthorizedWhenInUse 表示已授权同意
 返回kCLAuthorizationStatusNotDetermined 表示还没有确认过,等待确认
 返回kCLAuthorizationStatusDenied 表示授权已被拒绝
 */

- (RACSignal *)requestAuthorizationSignal {
    // 判断是否授权
    self.delegate = self;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // 没有授权就提示用户授权
        CLAuthorizationModel model = self.authorizationModel;
        if (model == CLAuthorizationModelWhenInUse) {
            [self requestWhenInUseAuthorization];
        } else if (model == CLAuthorizationModelAlways) {
            [self requestAlwaysAuthorization];
        }
        
        // 创建用户授权结果的信号
        return [[self rac_signalForSelector:@selector(locationManager:didChangeAuthorizationStatus:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id (id value) {
            if ([value[1] integerValue] == kCLAuthorizationStatusAuthorizedWhenInUse ||
                [value[1] integerValue] == kCLAuthorizationStatusAuthorizedAlways) {
                return value[1];
            } else if ([value[1] integerValue] == kCLAuthorizationStatusDenied) {
                return @(kCLAuthorizationStatusDenied);
            } else {
                return @(kCLAuthorizationStatusNotDetermined);
            }
        }];
    }
    
    return [RACSignal return :({
        id value = @(kCLAuthorizationStatusAuthorizedWhenInUse);
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
            [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
            value = @([CLLocationManager authorizationStatus]);
        } else {
            value = @(kCLAuthorizationStatusDenied);
        }
        value;
    })];
}

- (RACSignal *)requestCoreLocation {
    self.delegate = self;
    
    return [[[self requestAuthorizationSignal] filter:^BOOL (id value) {
        // 还没有授权就不往下走,等待授权
        if ([value integerValue] == kCLAuthorizationStatusNotDetermined) {
            return false;
        } else {
            return true;
        }
    }] flattenMap:^RACSignal *(id value) {
        // 授权过的 跟踪定位信息
        if ([value integerValue] == kCLAuthorizationStatusAuthorizedWhenInUse ||
            [value integerValue] == kCLAuthorizationStatusAuthorizedAlways) {
            return [[[[[[[self rac_signalForSelector:@selector(locationManager:didUpdateLocations:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id (id value) {
                // 取代理方法的第二个值
                return value[1];
            }] merge:[[self rac_signalForSelector:@selector(locationManager:didFailWithError:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id (id value) {
                // 定位失败返回错误信息
                return [RACSignal error:value[1]];
            }]] take:1] initially:^{
                // 信号开始前做什么
                [self startUpdatingLocation];
            }] finally:^{
                // 信号结束后做什么
                [self stopUpdatingLocation];
            }] flattenMap:^RACSignal *(id value) {
                CLLocation *location = [value firstObject];
                
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendNext:location];
                    [subscriber sendCompleted];
                    
                    return [RACDisposable disposableWithBlock:^{
                        self.delegate = nil;
                    }];
                }];
            }];
        } else if ([value integerValue] == kCLAuthorizationStatusDenied) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendError:[NSError errorWithDomain:@"" code:kCLAuthorizationStatusDenied userInfo:@{ NSLocalizedDescriptionKey: @"定位授权失败!" }]];
                
                return [RACDisposable disposableWithBlock:^{
                    self.delegate = nil;
                }];
            }];
        } else {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendError:[NSError errorWithDomain:@"" code:-1 userInfo:@{ NSLocalizedDescriptionKey: @"未知错误!" }]];
                
                return [RACDisposable disposableWithBlock:^{
                    self.delegate = nil;
                }];
            }];
        }
    }];
}

@end

#endif
