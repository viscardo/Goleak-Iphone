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
#import "ListLeakViewController.h"
#import <iAd/iAd.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>
@property (nonatomic, retain) IBOutlet UITableView *friendsTable;
@property (nonatomic, retain) NSMutableArray *leaksArray;
@property (nonatomic, retain) LeakEntity *leakChosen;
@property (retain, nonatomic) NSString *UserFbId;
@end
