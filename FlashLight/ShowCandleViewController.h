//
//  ShowCandleViewController.h
//  FlashLight
//
//  Created by Muhammad Azher on 21/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ShowCandleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *myGif;
//- (IBAction)resetMaxValues:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *myView;
//@property (weak, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UIImageView *capturedImage;
@property (weak, nonatomic) IBOutlet UIButton *captureImage;
- (IBAction)captureImageAction:(id)sender;
- (IBAction)changeCamera:(id)sender;
@end
