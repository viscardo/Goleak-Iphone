//
//  ListLeakViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 14/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "ListLeakViewController.h"
#import "LeakService.h"
#import "AppDelegate.h"
#import "LeakOperationResult.h"

@interface ListLeakViewController ()
@property (nonatomic, strong) NSMutableData *receivedData;
@end

@implementation ListLeakViewController

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
        self.loading.hidesWhenStopped = TRUE;
    
    if(self.leakChosen) {
        self.receivedData = [[NSMutableData alloc] init];
        self.userName.text = _leakChosen.userName;
        self.leakText.text = _leakChosen.leakText;
        //self.trueButton.titleLabel.text = [NSString stringWithFormat:@"True(%@)", _leakChosen.likes];
        //self.falseButton.titleLabel.text = [NSString stringWithFormat:@"False(%@)", _leakChosen.likes];

        
        self.trueButton.layer.borderWidth = 1.0f;
        self.trueButton.layer.cornerRadius = 5.0f ;
        self.trueButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        
        self.falseButton.layer.borderWidth = 1.0f;
        self.falseButton.layer.cornerRadius = 5.0f ;
        self.falseButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        
        self.userImage.layer.borderWidth = 2.0f;
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
        self.userImage.clipsToBounds = YES;
        self.userImage.layer.borderColor = [[UIColor whiteColor]CGColor];
        
        
        //self.friendsTable.dataSource = self;
        //self.navigationItem.title = leakChosen.userName;
        //_NumberOfLeaks.text = leakChosen.userName;
        
        //[[LeakService new] GetLeaksOnMe: leakChosen.userId :self  ];
        
        NSOperationQueue *queue = [NSOperationQueue new];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadImage:)
                                            object:_leakChosen.pictureUrl];
        [queue addOperation:operation];
    }

}

- (void)loadImage: (NSString *)url {
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
}

- (void)displayImage:(UIImage *)image {
    [self.userImage  setImage:image];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonFalseTouched:(id)sender {
    [self.loading startAnimating];
    self.receivedData = [[NSMutableData alloc] init];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [[LeakService new] GetDislike :self.leakChosen.codigo :appDelegate.userEntity.Id :self  ];
}

- (IBAction)buttonTrueTouched:(id)sender {
    [self.loading startAnimating];
    self.receivedData = [[NSMutableData alloc] init];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [[LeakService new] GetLike :self.leakChosen.codigo :appDelegate.userEntity.Id :self  ];
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
        [[[UIAlertView alloc] initWithTitle:@"Oh Yes!"
                                    message:opr.Message
                                   delegate:self
                          cancelButtonTitle:@"OK!"
                          otherButtonTitles:nil] show];
        
        [self performSegueWithIdentifier:@"segueBackFeed" sender:self ];
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
