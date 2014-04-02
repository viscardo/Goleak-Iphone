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
            LeakEntity * d = [[LeakEntity alloc]init];
            d.userName = [item objectForKey:@"UserName"];
            d.leakText = [item objectForKey:@"LeakText"];
            d.genderLeak = [item objectForKey:@"GenderLeak"];
            d.timeLeaked = [item objectForKey:@"TimeLeaked"] ;
            d.pictureUrl = [item objectForKey:@"PictureUrl"];
            d.likes = [item objectForKey:@"Likes"];
            d.dislikes = [item objectForKey:@"Dislikes"];
            d.codigo = [item objectForKey:@"Codigo"];
            [self.leaks addObject:d];
            

        }
    }
    
    return self;
}
@end

