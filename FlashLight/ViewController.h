//
//  ViewController.h
//  FlashLight
//
//  Created by Muhammad Azher on 18/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBColorPicker.h"
#import "iCarousel.h"
#import <StoreKit/SKStoreProductViewController.h>
#import <CoreLocation/CoreLocation.h>
#import <StoreKit/SKStoreProductViewController.h>

@interface ViewController : UIViewController <iCarouselDelegate,iCarouselDataSource,CLLocationManagerDelegate,SKStoreProductViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UISlider *screenBrightnessSlider;
@property (weak, nonatomic) IBOutlet UIButton *torchButton;
@property (weak, nonatomic) IBOutlet UISlider *torchIntensitySlider;
@property (weak, nonatomic) IBOutlet UIButton *compassButton;
@property (weak, nonatomic) IBOutlet UIButton *colorsButton;

//@property (nonatomic, strong) IBOutlet UIView *rect;
//@property (nonatomic, strong) VBColorPicker *cPicker;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)phoneIntensityChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *testCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *discoButton;
@property (weak, nonatomic) IBOutlet iCarousel *Carousel;
- (IBAction)moreApps:(id)sender;

@end

