//
//  DisclaimerViewController.h
//  goleak
//
//  Created by Roberto Viscardo on 01/06/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisclaimerViewController :  UIViewController <UIWebViewDelegate> {

    NSURL *theURL;
    NSString *theTitle;
    IBOutlet UIWebView *webView;
    
}

@end
