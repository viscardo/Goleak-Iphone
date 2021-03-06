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

-(void) UpdateFriends :(NSString*)Id :(NSString*)accesstoken :(NSMutableArray*)facebookFriends :(id)delegate
{
    NSArray *objects = [NSArray arrayWithObjects:facebookFriends,nil];
    
    NSString *commas = [objects componentsJoinedByString: @"," ];
    commas = [commas stringByReplacingOccurrencesOfString:@"("
                                         withString:@""];
    commas = [commas stringByReplacingOccurrencesOfString:@")"
                                               withString:@""];
    commas = [commas stringByReplacingOccurrencesOfString:@"\n"
                                               withString:@""];
    commas = [commas stringByReplacingOccurrencesOfString:@" "
                                               withString:@""];
    
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/PostUpdateFriends?Id=%@&accesstoken=%@&facebookFriends=%@", Id, accesstoken, commas];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
 
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
    

}


-(void) RemoveProfile :(NSString*)Id :(id)delegate
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/PostRemoveProfile?id=%@", Id];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
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
-(void) GetLeakOnwer :(NSString*) leakId :(NSString*)  userId :(id)delegate;
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/PostCheckLeakOnwer?LeakId=%@&userId=%@", leakId, userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
}

-(void) GetLike :(NSString*) leakId :(NSString*)  userId :(id)delegate
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/DeleteLeak?LeakId=%@&userId=%@&accesstoken=1", leakId, userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"DELETE"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:request delegate:delegate];
}

-(void) GetDislike :(NSString*) leakId :(NSString*)  userId :(id)delegate
{
    NSString *urlConcat = [ NSString stringWithFormat:@"http://www.goleak.com/API/Leak/PostReportSpam?LeakId=%@&userId=%@", leakId, userId];
    
    NSURL *url = [NSURL URLWithString: urlConcat];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
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
