//
//  UITextView+InputTextSignal.m
//  CoCo
//
//  Created by 陈明 on 2019/2/14.
//  Copyright © 2019 CoCo. All rights reserved.
//

#import "UITextView+InputTextSignal.h"
#import <ReactiveObjC/NSObject+RACDescription.h>

@implementation UITextView (InputTextSignal)
static void RACUseDelegateProxy_(UITextView *self) {
    if (self.delegate == (id)self.rac_delegateProxy) return;
    
    self.rac_delegateProxy.rac_proxiedDelegate = self.delegate;
    self.delegate = (id)self.rac_delegateProxy;
}

- (RACSignal *)rac_inputTextSignal {
    @weakify(self);
    RACSignal *signal = [[[[[[[RACSignal
                               defer:^RACSignal *_Nonnull {
                                   @strongify(self);
                                   
                                   return [RACSignal return :RACTuplePack(self)];
                               }]
                              concat:[self.rac_delegateProxy signalForSelector:@selector(textViewDidChange:)]]
                             reduceEach:^(UITextView *x) {
                                 return x;
                             }]
                            filter:^BOOL (UITextView *x) {
                                if (!x.markedTextRange) {
                                    return YES;
                                } else {
                                    return NO;
                                }
                            }]
                           map:^(UITextView *x) {
                               return x.text;
                           }]
                          takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ -rac_inputTextSignal", RACDescription(self)];
    
    RACUseDelegateProxy_(self);
    
    return signal;
}

@end
