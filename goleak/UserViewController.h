//
//  UserViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 30/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "LeakEntity.h"
#import <iAd/iAd.h>


@interface UserViewController : UIViewController<ADBannerViewDelegate>

@property (nonatomic, strong) UserEntity *UserChosen;
@property (nonatomic, strong) LeakEntity *leakChosen;

@property (weak, nonatomic) IBOutlet UILabel *NumberOfLeaks;

@property (weak, nonatomic) IBOutlet UIImageView *UserImage;

@property (nonatomic, strong) NSMutableArray *leaksArray;

@property (nonatomic, retain) IBOutlet UITableView *friendsTable;

@property (strong, nonatomic) IBOutlet UIButton *leakButton;




//-(id) initWithLeak:(LeakEntity *)_leak;
@end
