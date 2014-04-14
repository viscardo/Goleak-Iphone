//
//  UserViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 30/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeakEntity.h"

@interface UserViewController : UIViewController

@property (nonatomic, strong) LeakEntity *leakChosen;

@property (weak, nonatomic) IBOutlet UILabel *NumberOfLeaks;

@property (weak, nonatomic) IBOutlet UIImageView *UserImage;

@property (nonatomic, strong) NSMutableArray *leaksArray;

@property (nonatomic, retain) IBOutlet UITableView *friendsTable;




//-(id) initWithLeak:(LeakEntity *)_leak;
@end
