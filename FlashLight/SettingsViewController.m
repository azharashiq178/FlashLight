//
//  SettingsViewController.m
//  FlashLight
//
//  Created by Muhammad Azher on 24/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingTableViewCell.h"

@interface SettingsViewController ()
@property (nonatomic,strong) NSArray *settingData;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.settingData = [[NSArray alloc] initWithObjects:@"Auto Turn On",@"Disco",@"Compass",@"Gesture Driven Light Switch", nil];
    
    // Do any additional setup after loading the view.
    [self.settingsTableView reloadData];
}
//-(void)viewWillAppear:(BOOL)animated{
//    [self.navigationController.navigationBar setHidden:NO];
//}

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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.settingData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.settingName.text = [self.settingData objectAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    cell.settingIndicator.tag = indexPath.row;
    [cell showIndicator];
    
    return cell;
}
- (IBAction)dismissView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *tmpCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    
    return tmpCell;
}
@end
