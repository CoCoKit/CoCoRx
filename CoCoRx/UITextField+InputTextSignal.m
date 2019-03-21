//
//  UITextField+InputTextSignal.m
//  CoCo
//
//  Created by 陈明 on 2019/2/14.
//  Copyright © 2019 CoCo. All rights reserved.
//

#import "UITextField+InputTextSignal.h"
#import <ReactiveObjC/NSObject+RACDescription.h>

@implementation UITextField (InputTextSignal)
- (RACSignal *)rac_inputTextSignal {
    @weakify(self);
    
    return [[[[[[RACSignal
                 defer:^RACSignal *_Nonnull {
                     @strongify(self);
                     
                     return [RACSignal return :self];
                 }]
                concat:[self rac_signalForControlEvents:UIControlEventAllEditingEvents]]
               filter:^BOOL (UITextField *x) {
                   if (!x.markedTextRange) {
                       return YES;
                   } else {
                       return NO;
                   }
               }]
              map:^(UITextField *x) {
                  return x.text;
              }]
             takeUntil:self.rac_willDeallocSignal]
            setNameWithFormat:@"%@ -rac_inputTextSignal", RACDescription(self)];
}

@end
