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
    
    self.myBanner.delegate = self;
    self.myBanner.adUnitID = @"ca-app-pub-6412217023250030/4184269478";
    self.myBanner.rootViewController = self;
    //    [self.myBanner setAutoloadEnabled:YES];
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    //    request.testDevices = @[
    //                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
    //                            ];
    //    request.testDevices = @[ @"b5492ec64ecbad0f31be3bf73c85cf59" ];
    [self.myBanner loadRequest:request];
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
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    
    for (NSLayoutConstraint *constraint in self.myBanner.constraints) {
        if([constraint.identifier isEqualToString:@"my"]){
            constraint.constant = 50;
        }
    }
    [self.myBanner layoutIfNeeded];
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    for (NSLayoutConstraint *constraint in self.myBanner.constraints) {
        if([constraint.identifier isEqualToString:@"my"]){
            constraint.constant = 1;
        }
    }
    [self.myBanner layoutIfNeeded];
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}
@end
