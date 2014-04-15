//
//  ListLeakViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 14/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeakEntity.h"

@interface ListLeakViewController : UIViewController


@property (nonatomic, strong) LeakEntity *leakChosen;

@property (strong, nonatomic) IBOutlet UIButton *trueButton;
@property (strong, nonatomic) IBOutlet UIButton *falseButton;
@property (strong, nonatomic) IBOutlet UILabel  *userName;
@property (strong, nonatomic) IBOutlet UILabel  *genderLeak;
@property (strong, nonatomic) IBOutlet UILabel *leakText;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@end
