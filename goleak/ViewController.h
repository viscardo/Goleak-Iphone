//
//  ViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 26/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeakCell.h"
#import "LeakEntity.h"
#import "UserViewController.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *friendsTable;
@property (nonatomic, strong) NSMutableArray *leaksArray;
@property (nonatomic, retain) LeakEntity *leakChosen;
@end
