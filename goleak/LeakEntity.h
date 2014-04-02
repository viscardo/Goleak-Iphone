//
//  LeakEntity.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 27/03/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeakEntity : NSObject
{
    NSString *id;
    NSString *userName;
    NSString *pictureUrl;
    NSString *genderLeak;
    NSString *leakText;
    NSString *timeLeaked;
   
}

@property (nonatomic, retain) NSString *codigo;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *pictureUrl;
@property (nonatomic, retain) NSString *genderLeak;
@property (nonatomic, retain) NSString *leakText;
@property (nonatomic, retain) NSString *timeLeaked;
@property (nonatomic, retain) NSString *likes;
@property (nonatomic, retain) NSString *dislikes;

@end
