//
//  SettingTableViewCell.h
//  FlashLight
//
//  Created by Muhammad Azher on 24/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *settingName;
@property (weak, nonatomic) IBOutlet UISwitch *settingIndicator;
- (IBAction)didChangedIndicator:(id)sender;
-(void)showIndicator;

@end
