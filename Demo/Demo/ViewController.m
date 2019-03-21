//
//  ViewController.m
//  Demo
//
//  Created by iScarlett CoCo on 2019/2/9.
//  Copyright © 2019 iScarlett CoCo. All rights reserved.
//

#import "ViewController.h"
#import <CoCoRx/CoCoRx.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.manager.authorizationModel = CLAuthorizationModelAlways;
    [[self.manager requestCoreLocation] subscribeNext:^(CLLocation *location) {
        NSLog(@"1----%f %f",location.coordinate.latitude,location.coordinate.longitude);
    } error:^(NSError *error) {
        NSLog(@"1----%@",[NSString stringWithFormat:@"%@", error.localizedDescription]);
    }];
    
    [[self.manager requestCoreLocation] subscribeNext:^(CLLocation *location) {
        NSLog(@"2----%f %f",location.coordinate.latitude,location.coordinate.longitude);
    } error:^(NSError *error) {
        NSLog(@"2----%@",[NSString stringWithFormat:@"%@", error.localizedDescription]);
    }];
}


@end
