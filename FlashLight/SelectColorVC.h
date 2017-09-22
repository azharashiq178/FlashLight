//
//  SelectColorVC.h
//  FlashLight
//
//  Created by Muhammad Azher on 21/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBColorPicker.h"
@import GoogleMobileAds;

@interface SelectColorVC : UIViewController
@property (nonatomic, strong) IBOutlet UIView *rect;
- (IBAction)dismissScreen:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *screenBrightnessSlider;
@property (weak, nonatomic) IBOutlet GADBannerView *myBanner;
@property (nonatomic, strong) VBColorPicker *cPicker;
@end
