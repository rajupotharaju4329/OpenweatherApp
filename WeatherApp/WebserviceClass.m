//
//  WebserviceClass.m
//  WeatherApp
//
//  Created by Wipro on 08/03/17.
//  Copyright © 2017 Wipro. All rights reserved.
//

#import "WebserviceClass.h"
#import "AppDelegate.h"

@implementation WebserviceClass
- (void)weatherAPIWithCityName:(NSString *)city
                    andCountry:(NSString *)country
                  successBlock:(void(^)(NSData *response))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock
{
    [app_delegate showIndicatorWithText:@"Loading..."];

    self.authorizationSuccessBlock = successBlock;
    self.authorizationFailureBlock = failureBlock;
    // NSURLConnection call for authorization here
   
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?q=%@,%@&appid=27a0420d7f899376a73505b09614889e",city,country];
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // Create url connection and fire request
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          // do something with the data
                                          if (error == nil)
                                          {
                                              _responseData=[NSMutableData new];
                                              [_responseData appendData:data];
                                              if (self.authorizationSuccessBlock != nil) {
                                                  self.authorizationSuccessBlock(_responseData);
                                                  self.authorizationSuccessBlock = nil;
                                              }
                                          }
                                          else
                                          {
                                              if (self.authorizationFailureBlock != nil) {
                                                  self.authorizationFailureBlock(error);
                                                  self.authorizationFailureBlock = nil;
                                              }
                                          }
                                          [app_delegate removeIndicatorView];

                                      }];
    [dataTask resume];
    
}

@end
