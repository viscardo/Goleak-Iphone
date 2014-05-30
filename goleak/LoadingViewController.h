//
//  LoadingViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 18/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface LoadingViewController : UIViewController<ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@end
