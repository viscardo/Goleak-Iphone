//
//  UserCell.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 14/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *UserName;
@property (nonatomic, strong) IBOutlet UILabel *Leaks;
@property (nonatomic, strong) IBOutlet UIImageView *UserLeakedImage;


@end