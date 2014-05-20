//
//  LoginViewController.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 08/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;


@end
