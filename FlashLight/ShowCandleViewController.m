//
//  ShowCandleViewController.m
//  FlashLight
//
//  Created by Muhammad Azher on 21/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ShowCandleViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

@interface ShowCandleViewController ()
{
    CMMotionManager *manager;
}
@end

@implementation ShowCandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for(int i = 1 ;i <= 15;i++){
        NSString *tmpStr = [NSString stringWithFormat:@"flame%d.png",i];
        UIImage *tmpImage = [UIImage imageNamed:tmpStr];
        [tmpArray addObject:tmpImage];
    }
    self.myGif.layer.anchorPoint = CGPointMake(0.5, 1);
    self.myGif.animationImages = tmpArray;
    self.myGif.animationRepeatCount = 0;
    self.myGif.animationDuration = 1.0f;
    [self.myGif startAnimating];
//    self.myGif.image = [UIImage imageNamed:@"flame1.png"];
//    NSURL *imageURL = [NSURL URLWithString:@"https://media.giphy.com/media/TsgcDBU0LOjAs/giphy.gif"];
//    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//    self.myGif.image = [UIImage imageWithData:imageData];
//    self.myGif.animationDuration = 1.0f;
//    self.myGif.animationRepeatCount = 0;
//    [self.myGif startAnimating];
    // Do any additional setup after loading the view.
    
    
//    AVCaptureSession *session = [[AVCaptureSession alloc] init];
//    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    if (videoDevice)
//    {
//        NSError *error;
//        AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
//        if (!error)
//        {
//            if ([session canAddInput:videoInput])
//            {
//                [session addInput:videoInput];
//                AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
//                previewLayer.frame = self.myView.bounds;
//                [self.myView.layer addSublayer:previewLayer];
//                [session startRunning];
//                
//                
//            }
//        }
//    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    manager = [[CMMotionManager alloc] init];
    if([manager isGyroAvailable]){
//        [manager startGyroUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
////            NSLog(@"My Gyro Data along x is %f",gyroData.rotationRate.x);
//            NSLog(@"My Gyro Data along x is %f",gyroData.rotationRate.x);
//            NSLog(@"My Gyro Data along y is %f",gyroData.rotationRate.y);
//            
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
////                float tmp = gyroData.rotationRate.y * 180 / M_PI;
//                
////                if(tmp < 90 && tmp > 0){
////                    self.myGif.transform = CGAffineTransformMakeRotation(tmp);
////                }
//                
//            });
////            NSLog(@"My Gyro Data along z is %f",gyroData.rotationRate.z);
//        }];
//        CGFloat radians = atan2f(self.myGif.transform.a, self.myGif.transform.b);
//        CGFloat degrees = radians * (180 / M_PI);
//        NSLog(@"Current Angle is %f",degrees);
        [manager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                manager.accelerometerUpdateInterval = 0.1;
//                NSLog(@"My Gyro Data along x is %f",accelerometerData.acceleration.x);
//                NSLog(@"My Gyro Data along y is %f",accelerometerData.acceleration.y);
//                float ab = atan2((accelerometerData.acceleration.y),( accelerometerData.acceleration.x)) - atan2(0, 0);
                float ab = atan2f(accelerometerData.acceleration.y, accelerometerData.acceleration.x);
                ab = ab * (180 / M_PI);
                if(ab < 0){
                    ab = -1 * ab;
                }
                else{
                    float tmp = 180 - ab;
                    ab = 180 + tmp;
                }
                    NSLog(@"My Angle is %f",ab);
//                float tmpRad = 120 /180 * M_PI;
//                self.myGif.transform = CGAffineTransformIdentity;
                if(ab >= 0 && ab <= 180){
                    
                    float degrees1 = 90 - ab ;
                    
                    if(degrees1 < 0){
                        degrees1 = degrees1 * -1;
                    }
                    if(ab < 90){
                        degrees1 = 90 - ab;
                        degrees1 = degrees1 * -1;
                    }
                    float radians1 = ((degrees1) / 180.0 * M_PI);
                    self.myGif.layer.anchorPoint = CGPointMake(0.5, 1);
//                    self.myGif.layer.position = CGPointMake((self.view.frame.size.width / 2) +15 , self.view.frame.size.height - 200);
                    
                    self.myGif.transform = CGAffineTransformMakeRotation(radians1);
                }
                else{
                    self.myGif.transform = CGAffineTransformMakeRotation(0);
                }
                
                
                
                CGFloat radians = atan2f(self.myGif.transform.a, self.myGif.transform.b);
                CGFloat degrees = radians * (180 / M_PI);
                NSLog(@"Current Angle is %f",degrees);
                
            });
        }];
//        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        [manager startDeviceMotionUpdatesToQueue:queue
//                                                withHandler:^(CMDeviceMotion *motion, NSError *error) {
//                                                    
//                                                    // Get the attitude of the device
//                                                    CMAttitude *attitude = motion.attitude;
//                                                    
//                                                    // Get the pitch (in radians) and convert to degrees.
//                                                    NSLog(@"%f", attitude.pitch * 180.0/M_PI);
//                                                    
//                                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                                        // Update some UI
//                                                        self.myGif.transform = CGAffineTransformMakeRotation(attitude.pitch * 180.0/M_PI);
//                                                    });
//                                                    
//                                                }];
//        
//        NSLog(@"Device motion started");
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)dissmissScreen:(id)sender {
    [manager stopAccelerometerUpdates];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
