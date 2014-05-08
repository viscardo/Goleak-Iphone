//
//  LeakCell.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 27/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LeakCell.h"

@implementation LeakCell

@synthesize UserLeakedImage, genderLeak, leakText, timeLeaked, UserName, hourLeaked;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
