//
//  LeakService.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 01/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeakService : NSObject

-(void) GetMyLeakFedd :(int)userId :(id)delegate;
-(void) GetLoginByFacebook :(NSString*)fbId :(NSString*)accesstoken :(id)delegate;

@end
