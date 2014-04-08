//
//  AppDelegate.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 26/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) UINavigationController* navController;

@property (strong, nonatomic) LoginViewController *mainViewController;

- (void)showLoginView;

- (void)openSession;

-(BOOL)isLoged;

@end
