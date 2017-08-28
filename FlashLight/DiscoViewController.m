//
//  DiscoViewController.m
//  FlashLight
//
//  Created by Muhammad Azher on 28/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "DiscoViewController.h"
#define ARC4RANDOM_MAX      0x100000000
@interface DiscoViewController ()

@end

@implementation DiscoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for(int i = 0 ;i < 5;i++){
        NSString *tmpStr = [NSString stringWithFormat:@"myframe_%d.png",i];
        UIImage *tmpImage = [UIImage imageNamed:tmpStr];
        [tmpArray addObject:tmpImage];
    }
    self.animatedImageView.animationImages = tmpArray;
    self.animatedImageView.animationRepeatCount = 0;
    self.animatedImageView.animationDuration = 1.0f;
    [self.animatedImageView startAnimating];
    
//    [self.flashView setAlpha:1.0];
    
    // Fade it out
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        double val = ((double)arc4random() / ARC4RANDOM_MAX);
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self.flashView setAlpha:val];
                         }
                         completion:^(BOOL finished){}];
    }];
    [UIView animateWithDuration:2
                     animations:^{
                         
                     }
                     completion:^(BOOL finished){}];
    
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
- (IBAction)dismissScreen:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
