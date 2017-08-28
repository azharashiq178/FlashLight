//
//  SettingTableViewCell.m
//  FlashLight
//
//  Created by Muhammad Azher on 24/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didChangedIndicator:(id)sender {
//    if(self.settingIndicator.tag == )
    if([self.settingName.text  isEqualToString: @"Auto Turn On"]){
        [[NSUserDefaults standardUserDefaults] setBool:self.settingIndicator.isOn forKey:@"Auto"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([self.settingName.text  isEqualToString: @"Disco"]){
        [[NSUserDefaults standardUserDefaults] setBool:self.settingIndicator.isOn forKey:@"Disco"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else if([self.settingName.text  isEqualToString: @"Compass"]){
        NSLog(@"Compass");
        [[NSUserDefaults standardUserDefaults] setBool:self.settingIndicator.isOn forKey:self.settingName.text];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
//        NSLog(@"Value of user defaults is %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"Compass"]);
        
    }
    else if([self.settingName.text  isEqualToString: @"Gesture Driven Light Switch"]){
//        NSLog(@"Gesture Driven Light Switch");
        [[NSUserDefaults standardUserDefaults] setBool:self.settingIndicator.isOn forKey:@"Gesture"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else if([self.settingName.text  isEqualToString: @"Go Pro"]){
        
    }
    NSLog(@"Value changed at %d",self.settingIndicator.tag);
}
-(void)showIndicator{
    NSLog(@"My Setting name is %@",self.settingName.text);
    if([self.settingName.text isEqualToString: @"Go Pro"]){
        [self.settingIndicator setHidden:YES];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if([self.settingName.text isEqualToString:@"Compass"]){
        [self.settingIndicator setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Compass"]];
    }
    else if ([self.settingName.text isEqualToString:@"Gesture Driven Light Switch"]){
        [self.settingIndicator setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Gesture"]];
    }
    else if ([self.settingName.text isEqualToString:@"Auto Turn On"]){
        [self.settingIndicator setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Auto"]];
    }
    else if ([self.settingName.text isEqualToString:@"Disco"]){
        [self.settingIndicator setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"Disco"]];
    }
    
}
@end
