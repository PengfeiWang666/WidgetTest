//
//  WPFRootTabBarController.m
//  WidgetTest
//
//  Created by Leon on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFRootTabBarController.h"
#import "WPFBaseNavigationController.h"
#import "WPFDiscoverViewController.h"
#import "WPFMeViewController.h"

static NSString *const kClassKey    = @"rootVCClassString";
static NSString *const kTitleKey    = @"title";
static NSString *const kImgKey      = @"imageName";
static NSString *const kSelImgKey   = @"selectedImageName";


@interface WPFRootTabBarController ()

@end

@implementation WPFRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"UIViewController",
                                   kTitleKey  : @"微信",
                                   kImgKey    : @"tabbar_mainframe",
                                   kSelImgKey : @"tabbar_mainframeHL"},
                                 
                                 @{kClassKey  : @"UIViewController",
                                   kTitleKey  : @"通讯录",
                                   kImgKey    : @"tabbar_contacts",
                                   kSelImgKey : @"tabbar_contactsHL"},
                                 
                                 @{kClassKey  : @"WPFDiscoverViewController",
                                   kTitleKey  : @"发现",
                                   kImgKey    : @"tabbar_discover",
                                   kSelImgKey : @"tabbar_discoverHL"},
                                 
                                 @{kClassKey  : @"WPFMeViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"tabbar_me",
                                   kSelImgKey : @"tabbar_meHL"} ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        WPFBaseNavigationController *nav = [[WPFBaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
    self.selectedIndex = 0;
}

#pragma mark - Public Method
- (void)transferToRichScanVC {
    self.selectedIndex = 2;
    
    WPFBaseNavigationController *navVC = self.childViewControllers[2];
    WPFDiscoverViewController *discoverVC = (WPFDiscoverViewController *)navVC.topViewController;
    [discoverVC pushToRichScanVC];
}

- (void)transferToWebVCWithUrlString:(NSString *)urlString {
    self.selectedIndex = 2;
    
    WPFBaseNavigationController *navVC = self.childViewControllers[2];
    WPFDiscoverViewController *discoverVC = (WPFDiscoverViewController *)navVC.topViewController;
    [discoverVC pushToWebVCWithUrlString:urlString];
}

- (void)transferToPunchCardVC {
    self.selectedIndex = 3;
    WPFBaseNavigationController *navVC = self.childViewControllers[3];
    WPFMeViewController *discoverVC = (WPFMeViewController *)navVC.topViewController;
    [discoverVC showPunchCardVC];
}

- (void)transferToMessageVC {
    self.selectedIndex = 0;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"假装你已经进入了一个聊天界面，好么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"不要嘛" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSUserDefaults *sharedDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.wpf"];
        [sharedDefault setBool:YES forKey:@"kHandleUnreadMessage"];
    }];
    
    [alertVC addAction:cancleAction];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)transferToPindaoVC {
    self.selectedIndex = 1;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"想象一下，你现在已经进入了频道列表" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
