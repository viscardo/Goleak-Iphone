//
//  ConfigurationViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 15/05/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "ConfigurationViewController.h"

#import "LeakService.h"
#import "AppDelegate.h"
#import "LeakOperationResult.h"
#import <FacebookSDK/FacebookSDK.h>





@interface ConfigurationViewController ()
@property (nonatomic, strong) NSMutableData *receivedData;
@end

@implementation ConfigurationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
            self.loading.hidesWhenStopped = TRUE;
    
    
    self.removeProfile.layer.borderWidth = 1.0f;
    self.removeProfile.layer.cornerRadius = 5.0f ;
    self.removeProfile.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.updateFriend.layer.borderWidth = 1.0f;
    self.updateFriend.layer.cornerRadius = 5.0f ;
    self.updateFriend.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.logoutButton.layer.borderWidth = 1.0f;
    self.logoutButton.layer.cornerRadius = 5.0f ;
    self.logoutButton.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.logoImage.layer.borderWidth = 3.0f;
    self.logoImage.layer.cornerRadius = self.logoImage.frame.size.width/2;
    self.logoImage.clipsToBounds = YES;
    self.logoImage.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionUpdateFriends:(id)sender {
    
    [self.loading startAnimating];
    self.receivedData = [[NSMutableData alloc] init];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [[LeakService new] UpdateFriends :appDelegate.userEntity.Id :appDelegate.authToken :self  ];
}

- (IBAction)ActionRemoveProfile:(id)sender {
    
    [self.loading startAnimating];
    self.receivedData = [[NSMutableData alloc] init];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [[LeakService new] RemoveProfile :appDelegate.userEntity.Id :self  ];
    

}

- (IBAction)ActionLogOut:(id)sender {
    
    [self.loading startAnimating];
    [FBSession.activeSession closeAndClearTokenInformation];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.facebookId = nil;
    appDelegate.authToken = nil;
    
    UINavigationController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginID"];
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
    
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
        
        UINavigationController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginID"];
        [self presentViewController:monitorMenuViewController animated:NO completion:nil];
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

@end
