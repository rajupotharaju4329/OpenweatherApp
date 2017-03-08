//
//  ViewController.m
//  WeatherApp
//
//  Created by Wipro on 08/03/17.
//  Copyright © 2017 Wipro. All rights reserved.
//

#import "ViewController.h"
#import "WebserviceClass.h"
#import "WeatherForecastData.h"
#import "CustomWeatherTableViewCell.h"
#import "AppDelegate.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *weatherDataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:NO];
    /* Navigation bar titile */
    self.title = @"OpenWeatherMap";

    self.weatherDataArray = [NSMutableArray new];
    [self.weatherTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomWeatherTableViewCell"];
    self.weatherTableview.hidden= YES;
    
}

#pragma mark - Button Actions

-(void)alertViewWithText:(NSString *)text
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(IBAction)searchLocation:(id)sender
{
    
    if (self.texFieldCity.text.length == 0)
    {
        [self alertViewWithText:@"Please enter the CityName"];
    }
    else if (self.texFieldCountry.text.length == 0)
    {
        [self alertViewWithText:@"Please enter the Country"];
   
    }
    else
    {
        
        /* closing keyboard */
        [self.texFieldCity resignFirstResponder];
        [self.texFieldCountry resignFirstResponder];

        /* clear the data before call another request and reload the table view */
        [self.weatherDataArray removeAllObjects];
        [self.weatherTableview reloadData];
        self.weatherTableview.hidden= YES;

        /* Create the WebserviceClass object and URL request */
        WebserviceClass *webAPI = [[WebserviceClass alloc] init];
        
        [webAPI weatherAPIWithCityName:self.texFieldCity.text andCountry:self.texFieldCountry.text successBlock:^(NSData *data)
         {
             //converting raw data into json format
             NSError *e = nil;
             NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
             
             if (!jsonArray) {
                 NSLog(@"Error parsing JSON: %@", e);
             } else {
                 
                 NSLog(@"array %@",jsonArray);
                 NSString *statusCode;
                 NSDictionary *cityDic;
                 NSArray *listArray;
                 statusCode = [jsonArray objectForKey:@"cod"];
                 cityDic = [jsonArray  objectForKey:@"city"];
                 listArray = [jsonArray  objectForKey:@"list"];
                 
                 if ([statusCode  isEqual: @"200"])
                 {
                     
                     for (int i = 0; i < listArray.count; i ++ )
                     {
                         WeatherForecastData* weatherData = [WeatherForecastData new];
                         weatherData.cityName = [cityDic objectForKey:@"name"];
                         weatherData.countryName = [cityDic objectForKey:@"country"];
                         weatherData.dt_txt = [[listArray valueForKey:@"dt_txt"] objectAtIndex:i];
                         weatherData.currentTemp = [[[listArray objectAtIndex:i] valueForKey:@"main"] objectForKey:@"temp"];
                         weatherData.temp_max = [[[listArray objectAtIndex:i] valueForKey:@"main"] objectForKey:@"temp_max"];
                         weatherData.temp_min = [[[listArray objectAtIndex:i] valueForKey:@"main"] objectForKey:@"temp_min"];
                         weatherData.humidity = [[[listArray objectAtIndex:i] valueForKey:@"main"] objectForKey:@"humidity"];
                         weatherData.weatherDescription = [[[[listArray objectAtIndex:i] objectForKey:@"weather"] objectAtIndex:0] valueForKey:@"description"];
                         
                         [self.weatherDataArray addObject:weatherData];
                         
                     }
                     self.weatherTableview.hidden= NO;

                     [self.weatherTableview reloadData];
                     /*updating the UI with updated data*/
                     [self.weatherTableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
                     
                     /*stop the loader animation  */
                     [self performSelectorOnMainThread:@selector(removeIndicatorView) withObject:nil waitUntilDone:YES];
                     
                     self.weatherTableview.allowsSelection = NO;
                     
                     
                 }
             }
             
         }
                          failureBlock:^(NSError *error)
         {
         }];
    }
}


-(void)removeIndicatorView
{
    [app_delegate removeIndicatorView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weatherDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*create the reuseable cell*/
    static NSString *CellIdentifier = @"cell";
    
    CustomWeatherTableViewCell *cell =
    [self.weatherTableview dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    /*fill the updated data on cell*/
    WeatherForecastData* weatherData = [self.weatherDataArray objectAtIndex:indexPath.row];
    cell.lblCityName.text = [NSString stringWithFormat:@"%@",weatherData.cityName];
    cell.lblcountryName.text = [NSString stringWithFormat:@"%@",weatherData.weatherDescription];
    cell.lblcurrentTemp.text = [NSString stringWithFormat:@"%@",weatherData.currentTemp];
    cell.lbltemp_min.text = [NSString stringWithFormat:@"%@",weatherData.temp_min];
    cell.lbltemp_max.text = [NSString stringWithFormat:@"%@",weatherData.temp_max];
    cell.lbdt_txt.text = [NSString stringWithFormat:@"%@",weatherData.dt_txt];
    cell.lblhumidity.text = [NSString stringWithFormat:@"%@",weatherData.dt_txt];

    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
