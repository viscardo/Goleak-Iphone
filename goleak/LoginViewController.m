//
//  LoginViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 08/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LoginViewController.h"
#import "LoadingViewController.h"
#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LeakService.h"
#import "LeakService.h"
#import "LeakOperationResult.h"
#import "AppDelegate.h"

@interface LoginViewController ()
- (IBAction)buttonClicked:(id)sender;
@property (nonatomic, strong) NSMutableData *receivedData;
@end

@implementation LoginViewController



- (void)viewDidLoad
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                self.loading.hidesWhenStopped = TRUE;
    
    self.loginButton.layer.borderWidth = 1.0f;
    self.loginButton.layer.cornerRadius = 5.0f ;
    self.loginButton.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.logoImage.layer.borderWidth = 3.0f;
    self.logoImage.layer.cornerRadius = self.logoImage.frame.size.width/2;
    self.logoImage.clipsToBounds = YES;
    self.logoImage.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    if(appDelegate.facebookId != nil && appDelegate.authToken != nil)
    {
            self.receivedData = [[NSMutableData alloc] init];
        //Colocar o chamado em uma outra view e entao redirecionar
        [[LeakService new] GetLoginByFacebook :appDelegate.facebookId : appDelegate.authToken :self  ];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonTouched:(id)sender
{
    if ([_disclaimer isOn]) {
        NSLog(@"its on!");
             [self.loading startAnimating];
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[ @"user_friends", @"email", @"basic_info", @"public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
        
        }
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Go Leak"
                                    message:@"You must agree with ours terms before log into our Network."
                                   delegate:self
                          cancelButtonTitle:@"OK!"
                          otherButtonTitles:nil] show];
    }

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
    

    
    LeakOperationResult *opr = [[LeakOperationResult alloc]initWithUser:self.receivedData];
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    appDelegate.userEntity = opr.userEntity;
    
    
    if(appDelegate.userEntity.FriendsCount == 0)
    {
        LoadingViewController *LoadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loading"];
        [self presentViewController:LoadingViewController animated:NO completion:nil];
    }
   else
   {
    
    UITabBarController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarId"];
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
    
   }

    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}




@end
