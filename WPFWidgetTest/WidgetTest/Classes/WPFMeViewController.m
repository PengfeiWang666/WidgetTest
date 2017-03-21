//
//  WPFMeViewController.m
//  WidgetTest
//
//  Created by Leon on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFMeViewController.h"
#import "WPFPersonCenterHeaderCell.h"
#import "WPFPersonCenterCell.h"
#import "Masonry.h"
#import "AnimationTransitionViewController.h"

@interface WPFMeViewController ()

@end

@interface WPFMeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_personCenterTableView;
    CGRect oldFrame;
    UIImageView *fullScreenIV;
}


@end

@implementation WPFMeViewController

-(void)setupUI{
    _personCenterTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _personCenterTableView.dataSource = self;
    _personCenterTableView.delegate =  self;
    [_personCenterTableView registerNib:[UINib nibWithNibName:@"WPFPersonCenterHeaderCell" bundle:nil] forCellReuseIdentifier:@"WPFPersonCenterHeaderCell"];
    [_personCenterTableView registerNib:[UINib nibWithNibName:@"WPFPersonCenterCell" bundle:nil] forCellReuseIdentifier:@"WPFPersonCenterCell"];
    [self.view addSubview:_personCenterTableView];
    _personCenterTableView.tableFooterView = [UIView new];
    
    
    [_personCenterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
            case 0:
            return 1;
            break;
            case 1:
            return 4;
            break;
            case 2:
            return 1;
            break;
            case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return 42;
    }
    return 82;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 20;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)tapForOriginal:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.5 animations:^{
        fullScreenIV.frame = oldFrame;
        fullScreenIV.alpha = 0.03;
    } completion:^(BOOL finished) {
        fullScreenIV.alpha = 1;
        [fullScreenIV removeFromSuperview];
        
    }];
}
-(void)tapForFullScreen:(UITapGestureRecognizer *)tap{
    UIImageView *avatarIV = (UIImageView *)[tap view];
    oldFrame = [avatarIV convertRect:avatarIV.bounds toView:[UIApplication sharedApplication].keyWindow];
    if (fullScreenIV==nil) {
        fullScreenIV= [[UIImageView alloc]initWithFrame:avatarIV.frame];
    }
    fullScreenIV.backgroundColor = [UIColor blackColor];
    fullScreenIV.userInteractionEnabled = YES;
    fullScreenIV.image = avatarIV.image;
    fullScreenIV.contentMode = UIViewContentModeScaleAspectFit;
    [[UIApplication sharedApplication].keyWindow addSubview:fullScreenIV];
    
    [UIView animateWithDuration:0.5 animations:^{
        fullScreenIV.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
    UITapGestureRecognizer *originalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForOriginal:)];
    [fullScreenIV addGestureRecognizer:originalTap];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WPFPersonCenterHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"WPFPersonCenterHeaderCell"];
        //        headerCell.avatarIV.userInteractionEnabled = YES;
        //        UITapGestureRecognizer *fullScreenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForFullScreen:)];
        //        [headerCell.avatarIV addGestureRecognizer:fullScreenTap];
        //        headerCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return headerCell;
    }else{
        WPFPersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WPFPersonCenterCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==1) {//我的好友
            
            switch (indexPath.row) {
                    case 0:
                    cell.iconImgView.image = [UIImage imageNamed:@"MoreMyAlbum"];
                    cell.detailLabel.text = @"相册";
                    break;
                    case 1:
                    cell.iconImgView.image = [UIImage imageNamed:@"MoreMyFavorites"];
                    cell.detailLabel.text = @"收藏";
                    break;
                    case 2:
                    cell.iconImgView.image = [UIImage imageNamed:@"MoreMyBankCard"];
                    cell.detailLabel.text = @"钱包";
                    break;
                    case 3:
                    cell.iconImgView.image = [UIImage imageNamed:@"MyCardPackageIcon"];
                    cell.detailLabel.text = @"打卡";
                    break;
                    
                default:
                    break;
            }
            
        }else if (indexPath.section==2){//设置
            cell.iconImgView.image = [UIImage imageNamed:@"MoreExpressionShops"];
            cell.detailLabel.text = @"表情";
            
        }else if(indexPath.section==3){
            cell.iconImgView.image = [UIImage imageNamed:@"MoreSetting"];
            cell.detailLabel.text = @"设置";
            
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1 && indexPath.row == 3) {
        [self showPunchCardVC];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    fullScreenIV = nil;
    _personCenterTableView = nil;
}

#pragma mark - Public Method
- (void)showPunchCardVC {
    AnimationTransitionViewController *vc = [[AnimationTransitionViewController alloc] init];
    [self presentViewController:vc animated:YES completion:NULL];
}


@end
