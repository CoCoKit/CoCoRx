//
//  PHPhotoLibrary+CoCoRx.m
//  CoCoRx
//
//  Created by iScarlett CoCo on 2019/3/21.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import "PHPhotoLibrary+CoCoRx.h"

#ifdef Photos_Photos_h

@implementation PHPhotoLibrary (CoCoRx)
+ (RACSignal *)requestAuthorizationSignal {
    return [RACSignal createSignal:^RACDisposable *_Nullable (id<RACSubscriber>  _Nonnull subscriber) {
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
            // 没有授权就提示用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [subscriber sendNext:@(status)];
                } else {
                    [subscriber sendNext:@(status)];
                }
                [subscriber sendCompleted];
            }];
        } else {
            [subscriber sendNext:@([PHPhotoLibrary authorizationStatus])];
        }
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

@end

#endif
