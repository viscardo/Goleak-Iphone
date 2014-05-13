//
//  ListLeakViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 14/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeakEntity.h"
#import <iAd/iAd.h>

@interface ListLeakViewController : UIViewController<ADBannerViewDelegate>


@property (nonatomic, strong) LeakEntity *leakChosen;

@property (strong, nonatomic) IBOutlet UIButton *trueButton;
@property (strong, nonatomic) IBOutlet UIButton *falseButton;
@property (strong, nonatomic) IBOutlet UILabel  *userName;
@property (strong, nonatomic) IBOutlet UILabel  *genderLeak;
@property (strong, nonatomic) IBOutlet UITextView *leakText;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
