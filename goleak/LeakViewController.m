//
//  LeakViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 31/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LeakViewController.h"
#import "LeakService.h"
#import "LeakOperationResult.h"
#import "UserViewController.h"
#import "AppDelegate.h"

@interface LeakViewController ()

@property (nonatomic, strong) NSMutableData *receivedData;

@end



@implementation LeakViewController

@synthesize UserChosen;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.ButtonLeak.layer.borderWidth = 1.0f;
    self.ButtonLeak.layer.cornerRadius = 5.0f ;
    self.ButtonLeak.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.UserImage.layer.borderWidth = 2.0f;
    self.UserImage.layer.cornerRadius = self.UserImage.frame.size.width/2;
    self.UserImage.clipsToBounds = YES;
    self.UserImage.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    if(self.UserChosen) {
        self.receivedData = [[NSMutableData alloc] init];

        //self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", UserChosen.FirstName, UserChosen.LastName ];
        _UserName.text = [NSString stringWithFormat:@"%@ %@", UserChosen.FirstName, UserChosen.LastName ];
        

        
        NSOperationQueue *queue = [NSOperationQueue new];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadImage:)
                                            object:UserChosen.PicUrl];
        [queue addOperation:operation];
    }
}

- (void)loadImage: (NSString *)url {
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
}

- (void)displayImage:(UIImage *)image {
    [_UserImage  setImage:image];
    //[loading stopAnimating];
}

- (IBAction)buttonLeakTouched:(id)sender {
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [[LeakService new] GetCreateLeak : _LeakText.text  :UserChosen.Id :appDelegate.userEntity.Id :self  ];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"segueLeakBackUser"])
    {
        UserViewController *UserVC = (UserViewController *)[segue destinationViewController];
        
        UserVC.UserChosen = [[UserEntity alloc]init];
        UserVC.UserChosen.Id = UserChosen.Id;
        UserVC.UserChosen.PicUrl = UserChosen.PicUrl;
        UserVC.UserChosen.FirstName = UserChosen.FirstName;
        UserVC.UserChosen.LastName = UserChosen.LastName;
        UserVC.UserChosen.FacebookId = UserChosen.FacebookId;
        
    }
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    //NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    //[self.loading stopAnimating];
    
    LeakOperationResult * opr = [[LeakOperationResult alloc]initWithBoolResult :self.receivedData];
    
    if(opr.result)
    {
        [[[UIAlertView alloc] initWithTitle:@"Oh Yes!"
                                    message:opr.Message
                                   delegate:self
                          cancelButtonTitle:@"OK!"
                          otherButtonTitles:nil] show];
        
        [self performSegueWithIdentifier:@"segueLeakBackUser" sender:self ];
    }
    else
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Oh No!"
                                    message:opr.Message
                                   delegate:self
                          cancelButtonTitle:@"OK!"
                          otherButtonTitles:nil] show];
    }
    
    
}

- (IBAction)textFieldDismiss:(id)sender {
    [_LeakText resignFirstResponder ];
    
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [[LeakService new] GetCreateLeak : _LeakText.text  :UserChosen.Id :appDelegate.userEntity.Id :self  ];
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

@end
