//
//  AppDelegate.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 26/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "UserEntity.h"
#import <FacebookSDK/FacebookSDK.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property  BOOL *isLogged;
@property (strong, nonatomic) NSString *facebookId;
@property (strong, nonatomic) NSString *authToken;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *customLoginViewController;
@property (strong, nonatomic) UserEntity *userEntity;
@property (strong, nonatomic) NSMutableArray *arrFacebookFriends;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;

@end
