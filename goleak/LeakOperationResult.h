//
//  LeakOperationResult.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 01/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"

@interface LeakOperationResult : NSObject

@property (nonatomic, strong)  NSMutableArray *leaks;
@property (strong, nonatomic) UserEntity *userEntity;

-(id) initWithLeakFeed:(NSData *)data;
-(id)initWithUser:(NSData *)data;

@end
