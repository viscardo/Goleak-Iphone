//
//  LeakCell.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 27/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeakCell : UITableViewCell
{
    
}

@property (nonatomic, strong) IBOutlet UILabel *UserName;
@property (nonatomic, strong) IBOutlet UILabel *genderLeak;
@property (nonatomic, strong) IBOutlet UILabel *leakText;
@property (nonatomic, strong) IBOutlet UILabel *timeLeaked;
@property (nonatomic, strong) IBOutlet UIImageView *UserLeakedImage;

@property (nonatomic, strong) IBOutlet UILabel *trueOpinion;

@property (nonatomic, strong) IBOutlet UILabel *falseOpinion;

@end
