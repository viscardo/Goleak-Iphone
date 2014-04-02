//
//  LeakService.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 01/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LeakService.h"

@implementation LeakService


-(void) GetMyLeakFedd :(int)userId :(id)delegate
{
    
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/GetMyLeakFedd?userId=%d", userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    
}

@end
