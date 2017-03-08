//
//  CustomWeatherTableViewCell.h
//  WeatherApp
//
//  Created by Wipro on 08/03/17.
//  Copyright © 2017 Wipro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWeatherTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel * lblCityName;
@property(nonatomic,weak)IBOutlet UILabel * lblcountryName;
@property(nonatomic,weak)IBOutlet UILabel * lblweatherDescription;
@property(nonatomic,weak)IBOutlet UILabel * lblcurrentTemp;
@property(nonatomic,weak)IBOutlet UILabel * lbltemp_min;
@property(nonatomic,weak)IBOutlet UILabel * lbltemp_max;
@property(nonatomic,weak)IBOutlet UILabel * lbdt_txt;
@property(nonatomic,weak)IBOutlet UILabel * lblhumidity;


@end
