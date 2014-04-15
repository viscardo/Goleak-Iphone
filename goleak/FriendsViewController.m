//
//  FriendsViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 31/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "FriendsViewController.h"
#import "LeakService.h"
#import "LeakOperationResult.h"
#import "AppDelegate.h"
#import "UserCell.h"

@interface FriendsViewController ()

@property (nonatomic, strong) NSMutableData *receivedData;

@end

@implementation FriendsViewController

@synthesize friendChosen;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.loading startAnimating];
    self.receivedData = [[NSMutableData alloc] init];
    self.friendsTable.dataSource = self;
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    [[LeakService new] GetFriends :appDelegate.userEntity.Id :self  ];
    
    

     
     
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
    
    LeakOperationResult * opr = [[LeakOperationResult alloc]initWithFriends:self.receivedData];
    
    self.leaksArray = opr.leaks;
    
    [self.friendsTable reloadData];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.leaksArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    friendChosen = [self.leaksArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"segueFriend" sender:self ];
    
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"segueUser"])
    {
        UserViewController *UserVC = (UserViewController *)[segue destinationViewController];
        
        UserVC.leakChosen = [[LeakEntity alloc]init];
        UserVC.leakChosen.userId = friendChosen.Id;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"userCell";
    UserCell *cell = nil;
    
    cell = (UserCell *)[self.friendsTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UserEntity *leak = [self.leaksArray objectAtIndex:[indexPath row]];
    
    if(!cell)
    {
        NSArray *leaks = [[NSBundle mainBundle]loadNibNamed:@"UserCell" owner:nil options:nil];
        
        for (id currenObject in leaks)
        {
            if([currenObject isKindOfClass:[UserCell class]])
            {
                cell = (UserCell *)currenObject;
                break;
            }
        }
        
    }
    
    cell.UserName.text =  [ NSString stringWithFormat:@"%@ %@", leak.FirstName, leak.LastName];
    cell.Leaks.text = @"0 Leaks";


    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        
        id path = leak.PicUrl;
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
