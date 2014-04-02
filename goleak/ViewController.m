//
//  ViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 26/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "ViewController.h"
#import "LeakService.h"
#import "LeakOperationResult.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableData *receivedData;

@end

@implementation ViewController

@synthesize leakChosen;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.loading startAnimating];
    self.receivedData = [[NSMutableData alloc] init];
    
    [[LeakService new] GetMyLeakFedd:1 : self  ];
    
    
    /*
	// Do any additional setup after loading the view, typically from a nib.
    _friendsTable.dataSource = self;
    _friendsTable.delegate = self;
    
    self.leaksArray = [[NSMutableArray alloc]init];
    
    
    for(int i=1; i<= 10; i++)
    {
        LeakEntity *entity = [[LeakEntity alloc]init];
        
        entity.userName =[ NSString stringWithFormat:@"Gisely %d",i];
        entity.leakText = [NSString stringWithFormat:@"Marginal do rabo enorme %d",i];
        entity.genderLeak = [NSString stringWithFormat:@"Um menino disse %d",i];
        entity.timeLeaked = [NSString stringWithFormat:@"%d dias",i];
        entity.pictureUrl = @"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/v/t1.0-1/c6.0.160.160/p160x160/1479081_10151805149041699_1990396732_n.jpg?oh=2d61dff19256849de6ae5bd387a4cfed&oe=53A1F7F0&__gda__=1404853227_161ee393e6133722eb1ecee11e81036d";

        
        [self.leaksArray addObject:entity];
    }
     
     */
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
    
    id path = leak.pictureUrl;
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    cell.UserLeakedImage.image  = img;
    

    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
