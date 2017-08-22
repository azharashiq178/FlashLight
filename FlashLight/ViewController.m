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
#import "AKPickerView.h"
#import "VBColorPicker.h"
#import "CollectionViewCell.h"


@interface ViewController ()
@property (nonatomic,strong) NSArray *myData;
@property (nonatomic,strong) AKPickerView *pickerView;
@property (assign) int numberItems;
@property (assign) int currentValue;
@end

@implementation ViewController
//@synthesize rect=_rect;
//@synthesize cPicker=_cPicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIScreen mainScreen] setBrightness:self.screenBrightnessSlider.value];
    [self.torchIntensitySlider setEnabled:NO];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myData = [[NSArray alloc] initWithObjects:@"  0  ",@"  1  ",@"  2  ",@"  3  ",@"  4  ",@"  5  ",@"  6  ",@"  7  ",@"  8  ",@"  SOS  ", nil];
    self.pickerView = [[AKPickerView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 40)];
    
    self.pickerView.delegate = self;
    
    self.pickerView.dataSource = self;
    
    self.numberItems = 10;
    
    self.currentValue = 0;
    
    [self.pickerView selectItem:(self.currentValue + (self.numberItems * 4)) animated:YES];
    
    [self.view addSubview:self.pickerView];
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
- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView{
    return self.numberItems * 6;
}
- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item{
    return [NSString stringWithFormat:@"%@", self.myData[item % self.numberItems]];
}
- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item{
        NSInteger rowValueSelected = item % self.numberItems;
        NSLog(@"row value selected: %@", self.myData[rowValueSelected]);
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
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 500;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row % 10];
    return cell;
}
@end
