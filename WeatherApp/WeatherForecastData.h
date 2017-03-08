//
//  WeatherForecastData.h
//  WeatherApp
//
//  Created by Wipro on 08/03/17.
//  Copyright © 2017 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherForecastList.h"

@interface WeatherForecastData : NSObject
@property(nonatomic) NSString * cityName;
@property(nonatomic) NSString * countryName;
@property(nonatomic) NSString * weatherDescription;

@property(nonatomic) NSString * currentTemp;
@property(nonatomic) NSString * temp_min;
@property(nonatomic) NSString * temp_max;
@property(nonatomic) NSString * dt_txt;
@property(nonatomic) NSString * humidity;

@end
