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

@interface ViewController : UIViewController <iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet UISlider *screenBrightnessSlider;
@property (weak, nonatomic) IBOutlet UIButton *torchButton;
@property (weak, nonatomic) IBOutlet UISlider *torchIntensitySlider;
@property (weak, nonatomic) IBOutlet UIButton *compassButton;

//@property (nonatomic, strong) IBOutlet UIView *rect;
//@property (nonatomic, strong) VBColorPicker *cPicker;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)phoneIntensityChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *testCollectionView;
@property (weak, nonatomic) IBOutlet iCarousel *Carousel;

@end

