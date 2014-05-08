//
//  LoginViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 08/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LoginViewController.h"
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
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
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
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
    
   
    
    UITabBarController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarId"];
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
    
    

    
}



@end
