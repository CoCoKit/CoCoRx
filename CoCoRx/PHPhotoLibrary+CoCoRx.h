//
//  PHPhotoLibrary+CoCoRx.h
//  CoCoRx
//
//  Created by iScarlett CoCo on 2019/3/21.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import <Photos/Photos.h>
#import <ReactiveObjC/ReactiveObjC.h>

#ifdef Photos_Photos_h

NS_ASSUME_NONNULL_BEGIN

@interface PHPhotoLibrary (CoCoRx)


+ (RACSignal *)requestAuthorizationSignal;

@end

NS_ASSUME_NONNULL_END

#endif
