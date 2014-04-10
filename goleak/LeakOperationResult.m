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



@synthesize leaks;

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
            NSString *avatar = [ NSString stringWithFormat:@"http://graph.facebook.com/%d/picture", fb];
            
          
            
            LeakEntity * d = [[LeakEntity alloc]init];

            d.userName = [[item objectForKey:@"UserLeaked"] objectForKey:@"FirstName"] ;
            
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
@end

