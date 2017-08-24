//
//  SettingsViewController.h
//  FlashLight
//
//  Created by Muhammad Azher on 24/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end
