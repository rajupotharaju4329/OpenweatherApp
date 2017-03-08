//
//  ViewController.h
//  WeatherApp
//
//  Created by Wipro on 08/03/17.
//  Copyright © 2017 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic,weak)IBOutlet UITableView *weatherTableview;
@property(nonatomic,weak)IBOutlet UITextField *texFieldCity;
@property(nonatomic,weak)IBOutlet UITextField *texFieldCountry;

@end

