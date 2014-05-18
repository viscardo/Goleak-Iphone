//
//  ConfigurationViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 15/05/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LeakEntity.h"
#import <iAd/iAd.h>

@interface ConfigurationViewController : UIViewController<ADBannerViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIButton *removeProfile;
@property (strong, nonatomic) IBOutlet UIButton *updateFriend;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;


@end
