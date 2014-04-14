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

@interface UserViewController ()
@property (nonatomic, strong) NSMutableData *receivedData;
@end


@implementation UserViewController

@synthesize leakChosen;

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

    if(self.leakChosen) {
            self.receivedData = [[NSMutableData alloc] init];
            self.friendsTable.dataSource = self;
        self.navigationItem.title = leakChosen.userName;
        _NumberOfLeaks.text = leakChosen.userName;
        
        [[LeakService new] GetMyLeakFedd: leakChosen.userId :self  ];

        NSOperationQueue *queue = [NSOperationQueue new];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadImage:)
                                            object:leakChosen.pictureUrl];
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
    
    [self performSegueWithIdentifier:@"segueUser" sender:self ];
    
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"segueUser"])
    {
        UserViewController *UserVC = (UserViewController *)[segue destinationViewController];
        
        UserVC.leakChosen = leakChosen;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"leakCell";
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
    cell.timeLeaked.text = leak.timeLeaked;
    cell.genderLeak.text = leak.genderLeak;
    
    cell.trueOpinion.text = [ NSString stringWithFormat:@"%@ True", leak.likes];
    cell.falseOpinion.text = [ NSString stringWithFormat:@"%@ False", leak.dislikes];
    
    
    //NSURL *url = [NSURL URLWithString:path];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    //UIImage *img = [[UIImage alloc] initWithData:data];
    
    //cell.UserLeakedImage.image  = img;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        
        id path = leak.pictureUrl;
        NSURL *url = [NSURL URLWithString:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.UserLeakedImage.image = img;
            //[cell.loading stopAnimating];
        });
    });
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
