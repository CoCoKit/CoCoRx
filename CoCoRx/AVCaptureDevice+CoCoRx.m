//
//  AVCaptureDevice+CoCoRx.m
//  CoCoRx
//
//  Created by iScarlett CoCo on 2019/3/21.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import "AVCaptureDevice+CoCoRx.h"
#import <AVFoundation/AVFoundation.h>

@implementation AVCaptureDevice (CoCoRx)
+ (RACSignal *)requestVideoAuthorizationSignal {
    return [RACSignal createSignal:^RACDisposable *_Nullable (id<RACSubscriber>  _Nonnull subscriber) {
        if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusNotDetermined) {
            // 没有授权就提示用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {// 相机权限
                if (granted) {
                    [subscriber sendNext:@(AVAuthorizationStatusAuthorized)];
                } else {
                    [subscriber sendNext:@([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo])];
                }
                [subscriber sendCompleted];
            }];
        } else {
            [subscriber sendNext:@([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo])];
        }
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

+ (RACSignal *)requestAudioAuthorizationSignal {
    return [RACSignal createSignal:^RACDisposable *_Nullable (id<RACSubscriber>  _Nonnull subscriber) {
        if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusNotDetermined) {
            // 没有授权就提示用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {// 相机权限
                if (granted) {
                    [subscriber sendNext:@(AVAuthorizationStatusAuthorized)];
                } else {
                    [subscriber sendNext:@([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio])];
                }
                [subscriber sendCompleted];
            }];
        } else {
            [subscriber sendNext:@([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio])];
        }
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

@end
