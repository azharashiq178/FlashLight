//
//  ViewController.m
//  FlashLight
//
//  Created by Muhammad Azher on 18/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VBColorPicker.h"
#import "CollectionViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreLocation/CLLocationManager.h>
#define ARC4RANDOM_MAX      0x100000000


@interface ViewController ()
{
    NSTimer *myTimer;
    AVCaptureDevice *device;
    CLLocationManager *locationManager;
}
@property (nonatomic,strong) NSArray *myData;
@property (assign) int numberItems;
@property (assign) int currentValue;

@end

@implementation ViewController
//@synthesize rect=_rect;
//@synthesize cPicker=_cPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.screenBrightnessSlider setThumbImage:[UIImage imageNamed:@"brightness_btn"] forState:UIControlStateNormal];
//    [self.screenBrightnessSlider setMaximumTrackImage:[UIImage imageNamed:@"brightness_line"] forState:UIControlStateNormal];
//    [self.screenBrightnessSlider setMinimumTrackImage:[UIImage imageNamed:@"brightness_line"] forState:UIControlStateNormal];
    
    
    [self.torchIntensitySlider setThumbImage:[UIImage imageNamed:@"brightness_btn"] forState:UIControlStateNormal];
    [self.torchIntensitySlider setMaximumTrackImage:[UIImage imageNamed:@"brightness_line"] forState:UIControlStateNormal];
    [self.torchIntensitySlider setMinimumTrackImage:[UIImage imageNamed:@"brightness_line"] forState:UIControlStateNormal];
    

//    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"Compass"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    _Carousel.type = iCarouselTypeLinear;
//    [[UIScreen mainScreen] setBrightness:self.screenBrightnessSlider.value];
//    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    device = nil;
    [self.torchIntensitySlider setEnabled:NO];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myData = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"SOS", nil];
    [self.Carousel reloadData];
    
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    [locationManager setDelegate:self];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingHeading];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"Auto"])
        [self flashAction:self];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flashAction:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.compassButton setHidden:![[NSUserDefaults standardUserDefaults] boolForKey:@"Compass"]];
    [self.discoButton setHidden:![[NSUserDefaults standardUserDefaults] boolForKey:@"Disco"]];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"Auto"])
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flashAction:) name:UIApplicationDidBecomeActiveNotification object:nil];
//    else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turnFlashOff:) name:UIApplicationDidBecomeActiveNotification object:nil];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)flashAction:(id)sender {
    [myTimer invalidate];
    myTimer = nil;
//    if(([self.torchButton.currentImage isEqual: [UIImage imageNamed:@"flash_on_btn"]])){
    if(device!=nil){
        [device lockForConfiguration:nil];
        [myTimer invalidate];
        myTimer = nil;
        
        [device setTorchMode:AVCaptureTorchModeOff];
        [device setFlashMode:AVCaptureFlashModeOff];
        [self.torchIntensitySlider setEnabled:NO];
//        [self.torchButton setTitle:@"Torch ON" forState:UIControlStateNormal];
        [self.torchButton setImage:[UIImage imageNamed:@"flash_normal_btn"] forState:UIControlStateNormal];
//        [self.torchButton.imageView setImage:[UIImage imageNamed:@"flash_normal_btn"]];
        [device unlockForConfiguration];
        device = nil;
    }
    else{
        device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        [self.torchButton.imageView setImage:[UIImage imageNamed:@"flash_on_btn"]];
    }
    if(device == nil){
        
//       device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    if ([device hasTorch] && [device hasFlash]){
        
        [device lockForConfiguration:nil];
        if (device.torchMode == AVCaptureTorchModeOff) {
            
            [device setTorchMode:AVCaptureTorchModeOn];
            
            [device setFlashMode:AVCaptureFlashModeOn];
            
            [self.torchIntensitySlider setEnabled:YES];
            
            [device setTorchModeOnWithLevel:self.torchIntensitySlider.value error:nil];
            
//            [self.torchButton setTitle:@"Torch OFF" forState:UIControlStateNormal];
//            [self.torchButton.imageView setImage:[UIImage imageNamed:@"flash_on_btn"]];
            [self.torchButton setImage:[UIImage imageNamed:@"flash_on_btn"] forState:UIControlStateNormal];
            if([_myData[self.Carousel.currentItemIndex]  isEqual: @"1"]){
                [self startTimerWithInterval:0.8];
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"2"]){
                [self startTimerWithInterval:0.7];
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"3"]){
                [self startTimerWithInterval:0.6];
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"4"]){
                [self startTimerWithInterval:0.5];
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"5"]){
                [self startTimerWithInterval:0.4];
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"6"]){
                [self startTimerWithInterval:0.3];
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"7"]){
                [self startTimerWithInterval:0.2];
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"8"]){
                [self startTimerWithInterval:0.1];
//                NSLog(@"i am here");
            }
            else if([_myData[self.Carousel.currentItemIndex]  isEqual: @"SOS"]){
                [myTimer invalidate];
                myTimer = nil;
                myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    [device lockForConfiguration:nil];
                    if (device.torchMode == AVCaptureTorchModeOn){
                        [device setTorchMode:AVCaptureTorchModeOff];
                        
                        [device setFlashMode:AVCaptureFlashModeOff];
                    }
                    else{
                        float val = ((float)arc4random() / ARC4RANDOM_MAX);
                        
//                        NSLog(@"My Val is %f",val);
                        
                        [device setTorchMode:AVCaptureTorchModeOn];
                        
                        [device setFlashMode:AVCaptureFlashModeOn];
                        
                        [device setTorchModeOnWithLevel:val error:nil];
                    }
                    
                    [device unlockForConfiguration];
                }];
            }
        } else {
            [myTimer invalidate];
            myTimer = nil;
            
            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
            [self.torchIntensitySlider setEnabled:NO];
//            [self.torchButton setTitle:@"Torch ON" forState:UIControlStateNormal];
//            [self.torchButton.imageView setImage:[UIImage imageNamed:@"flash_normal_btn"]];
            [self.torchButton setImage:[UIImage imageNamed:@"flash_normal_btn"] forState:UIControlStateNormal];
            
            device = nil;
        }
        [device unlockForConfiguration];
    }
}


//- (IBAction)sliderValueChanged:(id)sender {
//    
//    [[UIScreen mainScreen] setBrightness:self.screenBrightnessSlider.value];
//}

- (IBAction)phoneIntensityChanged:(id)sender {
    
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch] && [device hasFlash]){
        
        [device lockForConfiguration:nil];
        
        if (device.torchMode == AVCaptureTorchModeOn) {
            
            [device setTorchModeOnWithLevel:self.torchIntensitySlider.value error:nil];
        }
        
        [device unlockForConfiguration];
    }
}

//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    //return NSIntegerMax; -- this does not work on 64-bit CPUs, pick an arbitrary value that the user will realistically never scroll to like this...
//    return self.numberItems * 100;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [NSString stringWithFormat:@"%ld", row % self.numberItems];
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSInteger rowValueSelected = row % self.numberItems;
//    NSLog(@"row value selected: %ld", (long)rowValueSelected);
//}
- (IBAction)showColorsController:(id)sender {
    
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectColorVC"];
    
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)showFlameController:(id)sender {
    
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"showCandle"];
    
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)showCompassController:(id)sender {
    
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"showCompass"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.Carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [_myData count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 50)];
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 114)];
//        ((UIImageView *)view).image = [UIImage imageNamed:@"top_lines 2"];
//        [((UIImageView *)view) setFrame:CGRectMake(0, 0, 10, 50)];
        UIImageView *tmpImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 30, 50)];
        tmpImage.contentMode = UIViewContentModeScaleAspectFit;
        tmpImage.image = [UIImage imageNamed:@"top_lines 2"];
        [view addSubview:tmpImage];
        UIImageView *tmpImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 30, 50)];
        tmpImage1.contentMode = UIViewContentModeScaleAspectFit;
        tmpImage1.image = [UIImage imageNamed:@"top_lines 2"];
        [view addSubview:tmpImage1];
        //        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, 30, 25)];
        label.backgroundColor = [UIColor clearColor];
        UIImageView *bottomGrayLine = [[UIImageView alloc] initWithFrame:CGRectMake(13, 100, 2, 10)];
        bottomGrayLine.image = [UIImage imageNamed:@"gray_line"];
        bottomGrayLine.tag = 100;
        if(index == self.Carousel.currentItemIndex){
            [label setTextColor:[UIColor redColor]];
            bottomGrayLine.image = [UIImage imageNamed:@"red_line"];
        }
        else{
            [label setTextColor:[UIColor whiteColor]];
            bottomGrayLine.image = [UIImage imageNamed:@"gray_line"];
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:13];
        label.tag = 1;
        [view addSubview:label];
        
        
        [view addSubview:bottomGrayLine];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = _myData[index];
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    
    switch (option) {
        case iCarouselOptionWrap:
            return YES;
            break;
            
        default:
            break;
    }
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    
    return value;
}
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
//    AudioServicesPlaySystemSound(1104);
//    NSLog(@"My Selected index %ld",self.Carousel.currentItemIndex);
    UIView *mySuperView = [self.Carousel currentItemView];
    for(UIView *view in mySuperView.subviews){
        if([view isKindOfClass:[UILabel class]]){
            UILabel *tmpLabel = (UILabel *)view;
            [tmpLabel setTextColor:[UIColor whiteColor]];
            [view removeFromSuperview];
            [mySuperView addSubview:tmpLabel];
        }
        if([view isKindOfClass:[UIImageView class]]){
            if(view.tag == 100){
                [(UIImageView *)view setImage:[UIImage imageNamed:@"gray_line"]];
            }
        }
        
    }
    UIView *mySuperView1 = [self.Carousel itemViewAtIndex:index];
    for(UIView *view in mySuperView1.subviews){
        if([view isKindOfClass:[UILabel class]]){
            UILabel *tmpLabel = (UILabel *)view;
            [tmpLabel setTextColor:[UIColor redColor]];
            [view removeFromSuperview];
            [mySuperView1 addSubview:tmpLabel];
        }
        if([view isKindOfClass:[UIImageView class]]){
            if(view.tag == 100){
                [(UIImageView *)view setImage:[UIImage imageNamed:@"red_line"]];
            }
        }
    }
    if(device != nil){
        if(![self.myData[index]  isEqualToString: @"SOS"] && ![self.myData[index]  isEqualToString: @"0"]){
            [myTimer invalidate];
            myTimer = nil;
            device = nil;
            device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            
            float tmp = 1 - (index / 10.0f);
            [self startTimerWithInterval:tmp];
        }
        else if ([self.myData[index] isEqualToString:@"0"]){
            [myTimer invalidate];
            myTimer = nil;
            device = nil;
            
            device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOn];
            
            [device setFlashMode:AVCaptureFlashModeOn];
            [device unlockForConfiguration];
        }
        else{
            [myTimer invalidate];
            myTimer = nil;
            myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [device lockForConfiguration:nil];
                if (device.torchMode == AVCaptureTorchModeOn){
                    [device setTorchMode:AVCaptureTorchModeOff];
                    
                    [device setFlashMode:AVCaptureFlashModeOff];
                    [self.torchButton setImage:[UIImage imageNamed:@"flash_normal_btn"] forState:UIControlStateNormal];
                }
                else{
                    float val = ((float)arc4random() / ARC4RANDOM_MAX);
//                    NSLog(@"My Val is %f",val);
                    
                    [device setTorchMode:AVCaptureTorchModeOn];
                    
                    [device setFlashMode:AVCaptureFlashModeOn];
                    [device setTorchModeOnWithLevel:val error:nil];
                    [self.torchButton setImage:[UIImage imageNamed:@"flash_on_btn"] forState:UIControlStateNormal];
                }
                
                [device unlockForConfiguration];
            }];
        }
    }
//    NSLog(@"You Selected %@",self.myData[index]);
    
}
-(void)carouselDidEndDecelerating:(iCarousel *)carousel{
    NSInteger index = carousel.currentItemIndex;
    if(device != nil){
        if(![self.myData[index]  isEqualToString: @"SOS"] && ![self.myData[index]  isEqualToString: @"0"]){
            [myTimer invalidate];
            myTimer = nil;
            device = nil;
            device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            
            float tmp = 1 - (index / 10.0f);
            [self startTimerWithInterval:tmp];
        }
        else if ([self.myData[index] isEqualToString:@"0"]){
            [myTimer invalidate];
            myTimer = nil;
            device = nil;
            
            device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOn];
            
            [device setFlashMode:AVCaptureFlashModeOn];
            [device unlockForConfiguration];
        }
        else{
            [myTimer invalidate];
            myTimer = nil;
            myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [device lockForConfiguration:nil];
                if (device.torchMode == AVCaptureTorchModeOn){
                    [device setTorchMode:AVCaptureTorchModeOff];
                    
                    [device setFlashMode:AVCaptureFlashModeOff];
                    [self.torchButton setImage:[UIImage imageNamed:@"flash_normal_btn"] forState:UIControlStateNormal];
                }
                else{
                    float val = ((float)arc4random() / ARC4RANDOM_MAX);
                    //                    NSLog(@"My Val is %f",val);
                    
                    [device setTorchMode:AVCaptureTorchModeOn];
                    
                    [device setFlashMode:AVCaptureFlashModeOn];
                    [device setTorchModeOnWithLevel:val error:nil];
                    [self.torchButton setImage:[UIImage imageNamed:@"flash_on_btn"] forState:UIControlStateNormal];
                }
                
                [device unlockForConfiguration];
            }];
        }
    }

    UIView *mySuperView = [carousel currentItemView];
    for(UIView *view in mySuperView.subviews){
        if([view isKindOfClass:[UILabel class]]){
            [view setTintColor:[UIColor redColor]];
            UILabel *tmpLabel = (UILabel *)view;
            [tmpLabel setTextColor:[UIColor redColor]];
            [view removeFromSuperview];
            [mySuperView addSubview:tmpLabel];
        }
        if([view isKindOfClass:[UIImageView class]]){
            if(view.tag == 100){
                [(UIImageView *)view setImage:[UIImage imageNamed:@"red_line"]];
            }
        }
    }
}
//-(void)carouselDidScroll:(iCarousel *)carousel{
//    if([carousel isDecelerating]){
//        NSLog(@"DRagging");
//        AudioServicesPlaySystemSound(1105);
//    }
////    AudioServicesPlaySystemSound(1105);
//}
-(void)carouselWillBeginDecelerating:(iCarousel *)carousel{
    UIView *mySuperView = [carousel currentItemView];
    for(UIView *view in mySuperView.subviews){
        if([view isKindOfClass:[UILabel class]]){
            [view setTintColor:[UIColor redColor]];
            UILabel *tmpLabel = (UILabel *)view;
            [tmpLabel setTextColor:[UIColor whiteColor]];
            [view removeFromSuperview];
            [mySuperView addSubview:tmpLabel];
        }
        if([view isKindOfClass:[UIImageView class]]){
            if(view.tag == 100){
                [(UIImageView *)view setImage:[UIImage imageNamed:@"gray_line"]];
            }
        }
    }
}
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
    AudioServicesPlaySystemSound(1104);
}
-(void)carouselWillBeginDragging:(iCarousel *)carousel{
    UIView *mySuperView = [carousel currentItemView];
    for(UIView *view in mySuperView.subviews){
        if([view isKindOfClass:[UILabel class]]){
            [view setTintColor:[UIColor redColor]];
            UILabel *tmpLabel = (UILabel *)view;
            [tmpLabel setTextColor:[UIColor whiteColor]];
            [view removeFromSuperview];
            [mySuperView addSubview:tmpLabel];
        }
        if([view isKindOfClass:[UIImageView class]]){
            if(view.tag == 100){
                [(UIImageView *)view setImage:[UIImage imageNamed:@"gray_line"]];
            }
        }
    }
}
-(void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
//    NSLog(@"Ended at %@",self.myData[self.Carousel.currentItemIndex]);
    NSInteger index = carousel.currentItemIndex;
    UIView *mySuperView = [carousel currentItemView];
    for(UIView *view in mySuperView.subviews){
        if([view isKindOfClass:[UILabel class]]){
            [view setTintColor:[UIColor redColor]];
            UILabel *tmpLabel = (UILabel *)view;
            [tmpLabel setTextColor:[UIColor redColor]];
            [view removeFromSuperview];
            [mySuperView addSubview:tmpLabel];
        }
        if([view isKindOfClass:[UIImageView class]]){
            if(view.tag == 100){
                [(UIImageView *)view setImage:[UIImage imageNamed:@"red_line"]];
            }
        }
    }
    if(device != nil){
        if(![self.myData[index]  isEqualToString: @"SOS"] && ![self.myData[index]  isEqualToString: @"0"]){
            [myTimer invalidate];
            myTimer = nil;
            device = nil;
            device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            
            float tmp = 1 - (index / 10.0f);
            [self startTimerWithInterval:tmp];
        }
        else if ([self.myData[index] isEqualToString:@"0"]){
            [myTimer invalidate];
            myTimer = nil;
            device = nil;
            
            device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOn];
            
            [device setFlashMode:AVCaptureFlashModeOn];
            [device unlockForConfiguration];
        }
        else{
            [myTimer invalidate];
            myTimer = nil;
            myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [device lockForConfiguration:nil];
                if (device.torchMode == AVCaptureTorchModeOn){
                    [device setTorchMode:AVCaptureTorchModeOff];
                    
                    [device setFlashMode:AVCaptureFlashModeOff];
                }
                else{
                    float val = ((float)arc4random() / ARC4RANDOM_MAX);
                    //                    NSLog(@"My Val is %f",val);
                    
                    [device setTorchMode:AVCaptureTorchModeOn];
                    
                    [device setFlashMode:AVCaptureFlashModeOn];
                    [device setTorchModeOnWithLevel:val error:nil];
                }
                
                [device unlockForConfiguration];
            }];
        }
    }
}
-(void)startTimerWithInterval:(float)second{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:second repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [device lockForConfiguration:nil];
        if (device.torchMode == AVCaptureTorchModeOn){
            [device setTorchMode:AVCaptureTorchModeOff];
            
            [device setFlashMode:AVCaptureFlashModeOff];
            [self.torchButton setImage:[UIImage imageNamed:@"flash_normal_btn"] forState:UIControlStateNormal];
        }
        else{
            
            [device setTorchMode:AVCaptureTorchModeOn];
            
            [device setFlashMode:AVCaptureFlashModeOn];
            
            [self.torchButton setImage:[UIImage imageNamed:@"flash_on_btn"] forState:UIControlStateNormal];
        }
      
        [device unlockForConfiguration];
        
    }];
}

- (IBAction)moreApps:(id)sender {
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    SKStoreProductViewController* spvc = [[SKStoreProductViewController alloc] init];
    [spvc loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @284417353}
                    completionBlock:^(BOOL result, NSError * _Nullable error) {
                        [self presentViewController:spvc animated:YES completion:nil];
                        [self.activityIndicator setHidden:YES];
                        [self.activityIndicator stopAnimating];
                    }];
    spvc.delegate = self;
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    //[manager stopUpdatingHeading];
    
    double rotation = newHeading.magneticHeading * 3.14159 / 180;
    
    [self.compassButton setTransform:CGAffineTransformMakeRotation(-rotation)];
}
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"Gesture"])
            [self flashAction:self];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
-(IBAction)turnFlashOff:(id)sender{
    if(device.flashMode == AVCaptureFlashModeOn){
        [device lockForConfiguration:nil];
        [self.torchButton setImage:[UIImage imageNamed:@"flash_normal_btn"] forState:UIControlStateNormal];
        [device setFlashMode:AVCaptureFlashModeOff];
        [device unlockForConfiguration];
        device = nil;
        [self flashAction:self];
    }
//    [self flashAction:self];
    
    
}
- (IBAction)showDisco:(id)sender {
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Disco"];
    
    [self presentViewController:vc animated:YES completion:nil];
}
@end
