//
//  AVCaptureDevice+CoCoRx.h
//  CoCoRx
//
//  Created by iScarlett CoCo on 2019/3/21.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVCaptureDevice (CoCoRx)

/*
 获取相机权限
 */
+ (RACSignal *)requestVideoAuthorizationSignal;

/*
 获取麦克风权限
 */
+ (RACSignal *)requestAudioAuthorizationSignal;

@end

NS_ASSUME_NONNULL_END
