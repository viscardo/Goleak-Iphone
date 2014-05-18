//
//  LeakOperationResult.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 01/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LeakOperationResult.h"
#import "LeakEntity.h"

@implementation LeakOperationResult



@synthesize leaks, result, Message;

-(id)initWithLeakFeed:(NSData *)data
{
    self = [super init];
    
    if(self)
    {
        leaks = [[NSMutableArray alloc] init];
        NSError *myError = nil;
        NSArray *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
        
        for(NSDictionary *item in res) {
            //[[item objectForKey:@"UserLeaked"] objectForKey:@"FirstName"] ;
            
            @try {
                // Try something
           
            
            NSString *fb = [[item objectForKey:@"UserLeaked"] objectForKey:@"Fb"];
            NSString *avatar = [ NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal", fb];
            
          
            
            LeakEntity * d = [[LeakEntity alloc]init];

            d.userName = [[item objectForKey:@"UserLeaked"] objectForKey:@"FirstName"] ;
            d.userId = [[item objectForKey:@"UserLeaked"] objectForKey:@"Id"] ;
            d.leakText = [item objectForKey:@"LeakText"];
            d.genderLeak = [item objectForKey:@"GenderLeak"];
            d.timeLeaked = [item objectForKey:@"CreatedOn"] ;
            d.pictureUrl = avatar; ;
            d.likes = [item objectForKey:@"TrueLeaks"];
            d.dislikes = [item objectForKey:@"FalseLeaks"];
            d.codigo = [item objectForKey:@"Id"];
            [self.leaks addObject:d];
            
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }

        }
    }
    
    return self;
}

-(id)initWithFriends:(NSData *)data
{
    self = [super init];
    
    if(self)
    {
        leaks = [[NSMutableArray alloc] init];
        NSError *myError = nil;
        NSArray *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
        
        for(NSDictionary *item in res) {
            
            
            @try {
                // Try something
                
                
                NSString *fb = [item objectForKey:@"Fb"];
                NSString *avatar = [ NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal", fb];
                
                
                
                UserEntity * d = [[UserEntity alloc]init];
                
                d.Id = [item objectForKey:@"Id"];

                d.FirstName = [item objectForKey:@"FirstName"];
                d.LastName = [item objectForKey:@"LastName"];
                d.LeaksCount = [item objectForKey:@"LeaksCount"];
                
                d.FacebookId = [item objectForKey:@"Fb"] ;
                d.PicUrl = avatar; ;

                
                [self.leaks addObject:d];
                
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
            
        }
    }
    
    return self;
}


-(id)initWithUser:(NSData *)data
{
    self = [super init];
    
    if(self)
    {
        leaks = [[NSMutableArray alloc] init];
        NSError *myError = nil;
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
        

            @try {
                // Try something

                UserEntity * d = [[UserEntity alloc]init];
                
                d.Id = [res objectForKey:@"Id"];
                d.FirstName = [res objectForKey:@"FirstName"];
                d.LastName = [res objectForKey:@"LastName"];
                d.FacebookId = [res objectForKey:@"Fb"];
                NSString *fbuid = d.FacebookId;
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", fbuid]];
                
                d.PicUrl= url.path;
                //[ NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", d.FacebookId];
                
                self.userEntity = d;
                
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
            
        
    }
    
    return self;
}



-(id)initWithBoolResult:(NSData *)data
{
    self = [super init];
    
    if(self)
    {
        leaks = [[NSMutableArray alloc] init];
        NSError *myError = nil;
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
        
        
        @try {
            // Try something
            self.result = [[res objectForKey:@"Sucess"] boolValue];
            self.Message = [res objectForKey:@"Message"];

            
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
        
        
    }
    
    return self;
}

@end

