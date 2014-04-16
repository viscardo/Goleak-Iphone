//
//  LeakService.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 01/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LeakService.h"

@implementation LeakService


-(void) GetMyLeakFedd :(NSString*)userId :(id)delegate
{
    
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/GetMyLeakFedd?userId=%@", userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    
}

-(void) GetLeaksOnMe :(NSString*)userId :(id)delegate
{
    
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/GetLeaksOnMe?userId=%@", userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    
}

-(void) GetFriends :(NSString*)Id :(id)delegate
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/GetFriends?id=%@", Id];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
}

-(void) GetLoginByFacebook :(NSString*)fbId :(NSString*)accesstoken :(id)delegate
{
    
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/GetLoginByFacebook?fbId=%@&accesstoken=%@", fbId, accesstoken];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    
}


-(void) GetLike :(NSString*) leakId :(NSString*)  userId :(id)delegate
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/GetLike?LeakId=%@&userId=%@", leakId, userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
}

-(void) GetDislike :(NSString*) leakId :(NSString*)  userId :(id)delegate
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/GetDislike?LeakId=%@&userId=%@", leakId, userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
}


-(void) GetCreateLeak :(NSString*) LeakText :(NSString*) UserLeakedId :(NSString*)  userId :(id)delegate
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/PostCreateLeak?LeakText=%@&UserLeakedId=%@&userId=%@", LeakText, UserLeakedId, userId];
    

    NSString *encodedString = [urlConcat stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:encodedString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
}




@end
