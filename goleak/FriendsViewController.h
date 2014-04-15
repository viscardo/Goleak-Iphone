//
//  FriendsViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 31/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewController.h"
#import "UserEntity.h"

@interface FriendsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *friendsTable;
@property (nonatomic, retain) NSMutableArray *leaksArray;
@property (nonatomic, retain) UserEntity *friendChosen;
@property (retain, nonatomic) NSString *UserFbId;

@end
