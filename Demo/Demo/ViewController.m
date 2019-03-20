//
//  ViewController.m
//  Demo
//
//  Created by iScarlett CoCo on 2019/2/9.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import "ViewController.h"
#import <CoCoTextEditKit/CoCoTextEditKit.h>
#import <CoCoCategorys/UIImage+CoCoColor.h>
#import <CoCoKit/CoCoKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    coco_weakSelf
    runAsyncOnMainQueueAfter(3, ^{
        coco_strongSelf
        UIImage *image = [UIImage imageNamed:@"test.JPG"];
        NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"aaa"];
        CoCoTextEditorController *vc = [[CoCoTextEditorController alloc] initWithAttributeString:attribute];
        [self presentViewController:vc animated:YES completion:nil];
    });
}


@end
