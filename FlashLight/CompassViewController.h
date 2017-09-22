//
//  CompassViewController.h
//  FlashLight
//
//  Created by Muhammad Azher on 22/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@import GoogleMobileAds;

@interface CompassViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *compassImage;
@property (weak, nonatomic) IBOutlet GADBannerView *myBanner;

@end
