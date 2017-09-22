//
//  SettingsViewController.h
//  FlashLight
//
//  Created by Muhammad Azher on 24/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface SettingsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *themesCollectionView;
@property (weak, nonatomic) IBOutlet GADBannerView *myBanner;


@end
