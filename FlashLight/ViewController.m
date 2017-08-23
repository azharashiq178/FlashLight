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


@interface ViewController ()
@property (nonatomic,strong) NSArray *myData;
@property (assign) int numberItems;
@property (assign) int currentValue;
@end

@implementation ViewController
//@synthesize rect=_rect;
//@synthesize cPicker=_cPicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    _Carousel.type = iCarouselTypeLinear;
    [[UIScreen mainScreen] setBrightness:self.screenBrightnessSlider.value];
    [self.torchIntensitySlider setEnabled:NO];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myData = [[NSArray alloc] initWithObjects:@"  0  ",@"  1  ",@"  2  ",@"  3  ",@"  4  ",@"  5  ",@"  6  ",@"  7  ",@"  8  ",@"  SOS  ", nil];
    [self.Carousel reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)flashAction:(id)sender {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        
        [device lockForConfiguration:nil];
        
        if (device.torchMode == AVCaptureTorchModeOff) {
            
            [device setTorchMode:AVCaptureTorchModeOn];
            
            [device setFlashMode:AVCaptureFlashModeOn];
            
            [self.torchIntensitySlider setEnabled:YES];
            
            [self.torchButton setTitle:@"Torch OFF" forState:UIControlStateNormal];
            
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
            [self.torchIntensitySlider setEnabled:NO];
            [self.torchButton setTitle:@"Torch ON" forState:UIControlStateNormal];
        }
        [device unlockForConfiguration];
    }
}


- (IBAction)sliderValueChanged:(id)sender {
    
    [[UIScreen mainScreen] setBrightness:self.screenBrightnessSlider.value];
}

- (IBAction)phoneIntensityChanged:(id)sender {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
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
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        //        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:16];
        label.tag = 1;
        [view addSubview:label];
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
    NSLog(@"You Selected %@",self.myData[index]);
}
@end
