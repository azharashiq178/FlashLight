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
@end

@implementation SelectColorVC
@synthesize rect=_rect;
@synthesize cPicker=_cPicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.screenBrightnessSlider setThumbImage:[UIImage imageNamed:@"brightness_btn"] forState:UIControlStateNormal];
    [self.screenBrightnessSlider setMaximumTrackImage:[UIImage imageNamed:@"top_seperator_line"] forState:UIControlStateNormal];
    [self.screenBrightnessSlider setMinimumTrackImage:[UIImage imageNamed:@"top_seperator_line"] forState:UIControlStateNormal];
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
@end
