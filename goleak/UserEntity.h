//
//  UserEntity.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 11/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject
{
    NSString *Id;
    NSString *FirstName;
    NSString *LastName;
    NSString *FacebookId;
    NSString *AuthToken;
    NSString *LeaksCount;
    int *FriendsCount;
    
}

@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) NSString *FirstName;
@property (nonatomic, retain) NSString *LastName;
@property (nonatomic, retain) NSString *FacebookId;
@property (nonatomic, retain) NSString *PicUrl;
@property (nonatomic, retain) NSString *AuthToken;
@property (nonatomic, retain) NSString *LeaksCount;
@property  int *FriendsCount;

@end
