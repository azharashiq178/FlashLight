//
//  SelectColorVC.m
//  FlashLight
//
//  Created by Muhammad Azher on 21/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "SelectColorVC.h"

@interface SelectColorVC ()
@property (nonatomic,strong) NSTimer *myTimer;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation SelectColorVC
@synthesize rect=_rect;
@synthesize cPicker=_cPicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interstitial = [self createAndLoadInterstitial];
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
    [self.screenBrightnessSlider setThumbImage:[UIImage imageNamed:@"brightness_btn"] forState:UIControlStateNormal];
    [self.screenBrightnessSlider setMaximumTrackImage:[UIImage imageNamed:@"brightness_line"] forState:UIControlStateNormal];
    [self.screenBrightnessSlider setMinimumTrackImage:[UIImage imageNamed:@"brightness_line"] forState:UIControlStateNormal];
    [[UIScreen mainScreen] setBrightness:self.screenBrightnessSlider.value];
    // Do any additional setup after loading the view.
    if (self.cPicker == nil) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.cPicker = [[VBColorPicker alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - 101, self.view.frame.size.height - 270, 202, 202)];
//        [_cPicker setCenter:self.view.center];
        [self.view addSubview:_cPicker];
        [_cPicker setDelegate:self];
        [_cPicker showPicker];
        
        // set default YES!
        [_cPicker setHideAfterSelection:NO];
    }
}
- (void) pickedColor:(UIColor *)color {
    [self.myTimer invalidate];
    [self.view setBackgroundColor:color];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self.view setBackgroundColor:[UIColor whiteColor]];
        if(self.view.backgroundColor == [UIColor whiteColor]){
            [self.view setBackgroundColor:color];
        }
        else{
            [self.view setBackgroundColor:[UIColor whiteColor]];
        }
    }];
    
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self.view setBackgroundColor:color];
//    }];
    //    [_cPicker hidePicker];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_cPicker isHidden]) {
        //        [_cPicker hidePicker];
    }
}

// show picker by double touch
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 2) {
        [_cPicker setCenter:[touch locationInView:self.view]];
        [_cPicker showPicker];
    }
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
//-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    [self.cPicker removeFromSuperview];
//    self.cPicker = nil;
//    if (self.cPicker == nil) {
//        [self.view setBackgroundColor:[UIColor grayColor]];
//        self.cPicker = [[VBColorPicker alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - 101, self.view.frame.size.height - 205, 202, 202)];
//        //        [_cPicker setCenter:self.view.center];
//        [self.view addSubview:_cPicker];
//        [_cPicker setDelegate:self];
//        [_cPicker showPicker];
//        
//        // set default YES!
//    }
//    
//}
- (IBAction)dismissScreen:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sliderValueChanged:(id)sender {
    
    [[UIScreen mainScreen] setBrightness:self.screenBrightnessSlider.value];
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
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    if (self.interstitial.isReady) {
//        [self.interstitial presentFromRootViewController:self];
//    }
}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}
- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
}
@end
