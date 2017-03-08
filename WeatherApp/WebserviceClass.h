//
//  WebserviceClass.h
//  WeatherApp
//
//  Created by Wipro on 08/03/17.
//  Copyright © 2017 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebserviceClass : NSObject
@property (nonatomic, copy) void(^authorizationSuccessBlock)(NSData *response);
@property (nonatomic, copy) void(^authorizationFailureBlock)(NSError *error);
@property(nonatomic)NSMutableData *responseData;

//***************  weatherAPI     *******************************
- (void)weatherAPIWithCityName:(NSString *)city
                     andCountry:(NSString *)country
                    successBlock:(void(^)(NSData *response))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;

@end
