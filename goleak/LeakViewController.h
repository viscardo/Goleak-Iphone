//
//  LeakViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 31/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import <iAd/iAd.h>

@interface LeakViewController : UIViewController<ADBannerViewDelegate>

@property (nonatomic, strong) UserEntity *UserChosen;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UITextField *LeakText;
@property (weak, nonatomic) IBOutlet UIButton *ButtonLeak;
- (IBAction)textFieldDismiss:(id)sender;

@end
