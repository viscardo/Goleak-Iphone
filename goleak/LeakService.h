//
//  LeakService.h
//  goleak
//
//  Created by ROBERTO JUNIOR on 01/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeakService : NSObject

-(void) GetMyLeakFedd :(NSString*)userId :(id)delegate;
-(void) GetLoginByFacebook :(NSString*)fbId :(NSString*)accesstoken :(id)delegate;
-(void) GetLeaksOnMe :(NSString*)userId :(id)delegate;
-(void) GetFriends :(NSString*)Id :(id)delegate;
-(void) GetLike :(NSString*) leakId :(NSString*)  userId :(id)delegate;
-(void) GetDislike :(NSString*) leakId :(NSString*)  userId :(id)delegate;
-(void) GetCreateLeak :(NSString*) LeakText :(NSString*) UserLeakedId :(NSString*)  userId :(id)delegate;

@end
