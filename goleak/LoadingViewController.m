//
//  LoadingViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 18/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LoadingViewController.h"
#import "AppDelegate.h"
#import "LeakOperationResult.h"
#import "LeakService.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoadingViewController ()
@property (nonatomic, strong) NSMutableData *receivedData;
@property (strong, nonatomic) NSMutableArray *arrFacebookFriends;
@end

@implementation LoadingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.loading startAnimating];
    self.logoImage.layer.borderWidth = 3.0f;
    self.logoImage.layer.cornerRadius = self.logoImage.frame.size.width/2;
    self.logoImage.clipsToBounds = YES;
    self.logoImage.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [[LeakService new] UpdateFriends :appDelegate.userEntity.Id :appDelegate.arrFacebookFriends :self  ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse: %@", [response MIMEType] );
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    //NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    [self.loading stopAnimating];
    self.loading.hidesWhenStopped = TRUE;
    
    
    LeakOperationResult * opr = [[LeakOperationResult alloc]initWithBoolResult :self.receivedData];
    
    if(opr.result)
    {
        [[[UIAlertView alloc] initWithTitle:@"Go Leak"
                                    message:opr.Message
                                   delegate:self
                          cancelButtonTitle:@"OK!"
                          otherButtonTitles:nil] show];
        
        
    }
    else
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Go Leak"
                                    message:opr.Message
                                   delegate:self
                          cancelButtonTitle:@"OK!"
                          otherButtonTitles:nil] show];
        
        
        [FBSession.activeSession closeAndClearTokenInformation];
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.facebookId = nil;
        appDelegate.authToken = nil;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        window.rootViewController = [storyboard instantiateInitialViewController];
        
    }
    
    
}



#pragma mark iAd Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}




@end
