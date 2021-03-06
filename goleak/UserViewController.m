//
//  UserViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 30/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "UserViewController.h"
#import "LeakCell.h"
#import "LeakService.h"
#import "LeakOperationResult.h"
#import "ListLeakViewController.h"
#import "LeakViewController.h"

@interface UserViewController ()
@property (nonatomic, strong) NSMutableData *receivedData;
@end


@implementation UserViewController

@synthesize UserChosen, leakChosen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.leakButton.layer.borderWidth = 1.0f;
    self.leakButton.layer.cornerRadius = 5.0f ;
    self.leakButton.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.UserImage.layer.borderWidth = 2.0f;
    self.UserImage.layer.cornerRadius = self.UserImage.frame.size.width/2;
    self.UserImage.clipsToBounds = YES;
    self.UserImage.layer.borderColor = [[UIColor whiteColor]CGColor];

    if(self.UserChosen) {
            self.receivedData = [[NSMutableData alloc] init];
            self.friendsTable.dataSource = self;
        self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", UserChosen.FirstName, UserChosen.LastName ];
        _NumberOfLeaks.text = [NSString stringWithFormat:@"%@ %@", UserChosen.FirstName, UserChosen.LastName ];
        
        [[LeakService new] GetLeaksOnMe :UserChosen.Id :self  ];

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
    
    //[self.loading stopAnimating];
    
    LeakOperationResult * opr = [[LeakOperationResult alloc]initWithLeakFeed:self.receivedData];
    
    self.leaksArray = opr.leaks;
    
    [self.friendsTable reloadData];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.leaksArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    leakChosen = [self.leaksArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"segueUserToLeak" sender:self ];
    
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"segueUserToLeak"])
    {
        ListLeakViewController *UserVC = (ListLeakViewController *)[segue destinationViewController];
        
        UserVC.leakChosen = leakChosen;
        
    }
    if ([[segue identifier] isEqualToString:@"segueLeak"])
    {
        LeakViewController *UserVC = (LeakViewController *)[segue destinationViewController];
        
        UserVC.UserChosen = [[UserEntity alloc]init];
        UserVC.UserChosen.Id = UserChosen.Id;
        UserVC.UserChosen.PicUrl = UserChosen.PicUrl;
        UserVC.UserChosen.FirstName = UserChosen.FirstName;
        UserVC.UserChosen.LastName = UserChosen.LastName;
        UserVC.UserChosen.FacebookId = UserChosen.FacebookId;
        
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *simpleTableIdentifier = @"leakCell";
    
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%@%i",@"leakCell",indexPath.row];
    LeakCell *cell = nil;
    
    cell = (LeakCell *)[self.friendsTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    LeakEntity *leak = [self.leaksArray objectAtIndex:[indexPath row]];
    
    if(!cell)
    {
        NSArray *leaks = [[NSBundle mainBundle]loadNibNamed:@"LeakCell" owner:nil options:nil];
        
        for (id currenObject in leaks)
        {
            if([currenObject isKindOfClass:[LeakCell class]])
            {
                cell = (LeakCell *)currenObject;
                break;
            }
        }
        
    }
    cell.UserName.text = leak.userName;
    cell.leakText.text = leak.leakText;

    NSArray* foo = [leak.timeLeaked componentsSeparatedByString: @"T"];
    cell.timeLeaked.text = [foo[0] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        cell.hourLeaked.text = [foo[1] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    cell.genderLeak.text = leak.genderLeak;
    
    cell.trueOpinion.text = [ NSString stringWithFormat:@"%@ True", leak.likes];
    cell.falseOpinion.text = [ NSString stringWithFormat:@"%@ False", leak.dislikes];
    
    
    //NSURL *url = [NSURL URLWithString:path];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    //UIImage *img = [[UIImage alloc] initWithData:data];
    
    cell.UserLeakedImage.image  = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        
        id path = leak.pictureUrl;
        NSURL *url = [NSURL URLWithString:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.UserLeakedImage.image = img;
            cell.UserLeakedImage.layer.borderWidth = 2.0f;
            cell.UserLeakedImage.layer.cornerRadius = cell.UserLeakedImage.frame.size.width/2;
            cell.UserLeakedImage.clipsToBounds = YES;
            cell.UserLeakedImage.layer.borderColor = [[UIColor whiteColor]CGColor];
            //[cell.loading stopAnimating];
        });
    });
    
    
    return cell;
}
- (IBAction)buttonLeakTouched:(id)sender {
    
        [self performSegueWithIdentifier:@"segueLeak" sender:self ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
