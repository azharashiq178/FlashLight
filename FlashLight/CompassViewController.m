//
//  CompassViewController.m
//  FlashLight
//
//  Created by Muhammad Azher on 22/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "CompassViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CompassViewController ()
{
    CLLocationManager *locationManager;
}

@end

@implementation CompassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    [locationManager setDelegate:self];
    locationManager.delegate = self;
     locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingHeading];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    //[manager stopUpdatingHeading];
    
    double rotation = newHeading.magneticHeading * 3.14159 / 180;
//    NSLog(@"Rotation is %f",rotation);
    
    [self.compassImage setTransform:CGAffineTransformMakeRotation(-rotation)];
}
- (IBAction)dismissView:(id)sender {
    [locationManager stopUpdatingHeading];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
