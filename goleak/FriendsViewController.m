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
@property (nonatomic, strong) NSArray *searchResults;

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

- (void)viewDidAppear
{
       [super viewDidLoad];
    
}

/* Begin Search Methods */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"FirstName contains[c] %@", searchText];
 
    _searchResults = [self.leaksArray  filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

/* End Search Methods */

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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
        
    } else {
        return [self.leaksArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.searchDisplayController.active) {
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        friendChosen = [_searchResults objectAtIndex:indexPath.row];
    } else {
        friendChosen = [self.leaksArray  objectAtIndex:indexPath.row];
    }
    
    
    [self performSegueWithIdentifier:@"segueFriend" sender:self ];
    
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"segueFriend"])
    {

        
        UserViewController *UserVC = (UserViewController *)[segue destinationViewController];
        
        UserVC.UserChosen = [[UserEntity alloc]init];
        UserVC.UserChosen.Id = friendChosen.Id;
        UserVC.UserChosen.PicUrl = friendChosen.PicUrl;
        UserVC.UserChosen.FirstName = friendChosen.FirstName;
        UserVC.UserChosen.LastName = friendChosen.LastName;
        UserVC.UserChosen.FacebookId = friendChosen.FacebookId;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *simpleTableIdentifier = @"userCell";
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%@%i",@"leakCell",indexPath.row];
    UserCell *cell = nil;
    
    cell = (UserCell *)[self.friendsTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UserEntity *leak = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        leak = [_searchResults objectAtIndex:indexPath.row];
    } else {
        leak = [self.leaksArray objectAtIndex:[indexPath row]];
    }

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
    cell.Leaks.text = [ NSString stringWithFormat:@"%@ Leaks", leak.LeaksCount];

    cell.UserLeakedImage.image = nil;

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        
        id path = leak.PicUrl;
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
