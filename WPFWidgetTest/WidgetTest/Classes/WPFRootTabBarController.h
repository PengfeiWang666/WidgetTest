//
//  WPFRootTabBarController.h
//  WidgetTest
//
//  Created by Leon on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPFRootTabBarController : UITabBarController

- (void)transferToRichScanVC;

- (void)transferToWebVCWithUrlString:(NSString *)urlString;

- (void)transferToPunchCardVC;

- (void)transferToMessageVC;

- (void)transferToPindaoVC;

@end
