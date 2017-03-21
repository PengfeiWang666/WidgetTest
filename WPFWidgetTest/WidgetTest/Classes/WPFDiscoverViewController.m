//
//  WPFDiscoverViewController.m
//  WidgetTest
//
//  Created by Leon on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFDiscoverViewController.h"
#import "Masonry.h"
#import "WPFPersonCenterCell.h"


@interface WPFDiscoverViewController ()

@end

@interface WPFDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *discoverTable;
}

@end

@implementation WPFDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
}
-(void)setupTable {
    discoverTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    discoverTable.delegate = self;
    discoverTable.dataSource = self;
    [discoverTable registerNib:[UINib nibWithNibName:@"WPFPersonCenterCell" bundle:nil] forCellReuseIdentifier:@"WPFPersonCenterCell"];
    [self.view addSubview:discoverTable];
    [discoverTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
            case 0:
            return 1;
            break;
            case 1:
            return 2;
            break;
            case 2:
            return 1;
            break;
            case 3:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WPFPersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WPFPersonCenterCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {//我的好友
        cell.iconImgView.image = [UIImage imageNamed:@"disIconShowAlbum"];
        cell.detailLabel.text = @"朋友圈";
        
    }else if (indexPath.section==1){//设置
        if (indexPath.row==0) {
            cell.iconImgView.image = [UIImage imageNamed:@"disIconQRCode"];
            cell.detailLabel.text = @"扫一扫";
            
        }else if (indexPath.row==1){
            cell.iconImgView.image = [UIImage imageNamed:@"disIconShake"];
            cell.detailLabel.text = @"摇一摇";
        }
        
    }else if(indexPath.section==2){
        cell.iconImgView.image = [UIImage imageNamed:@"disIconLocationService"];
        cell.detailLabel.text = @"附近的人";
    }else if(indexPath.section==3){
        if (indexPath.row==0) {
            cell.iconImgView.image = [UIImage imageNamed:@"disCreditCard_ShoppingBag"];
            cell.detailLabel.text = @"购物";
        }else if (indexPath.row==1){
            cell.iconImgView.image = [UIImage imageNamed:@"disMoreGame"];
            cell.detailLabel.text = @"游戏";
        }
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self pushToRichScanVC];
    } else if (indexPath.section == 3 && indexPath.row == 1) {
        
        [self pushToWebVCWithUrlString:@"test"];
    }
}

#pragma mark- Public Method
- (void)pushToRichScanVC {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"假装打开了扫一扫，好么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)pushToWebVCWithUrlString:(NSString *)urlString {
    UIViewController *testVC = [[UIViewController alloc] init];
    testVC.view.backgroundColor = [UIColor whiteColor];

    UILabel *introLabel = [[UILabel alloc] init];
    introLabel.text = @"很显然，这是一个 Web 活动页";
    [introLabel sizeToFit];
    introLabel.center = testVC.view.center;
    
    [testVC.view addSubview:introLabel];
    
    [self.navigationController pushViewController:testVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
