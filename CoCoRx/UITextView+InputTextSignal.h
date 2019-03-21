//
//  UITextView+InputTextSignal.h
//  CoCo
//
//  Created by 陈明 on 2019/2/14.
//  Copyright © 2019 CoCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (InputTextSignal)

- (RACSignal *)rac_inputTextSignal;// 屏蔽中文输入法智能联想的拼音
@end

NS_ASSUME_NONNULL_END
