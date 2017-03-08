//
//  AppDelegate.h
//  WeatherApp
//
//  Created by Wipro on 08/03/17.
//  Copyright © 2017 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#define app_delegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;

}

@property (strong, nonatomic) UIWindow *window;
- (void)showIndicatorWithText:(NSString *)message;
- (void)removeIndicatorView;

@end

