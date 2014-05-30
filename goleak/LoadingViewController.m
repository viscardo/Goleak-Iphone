//
//  LoadingViewController.m
//  goleak
//
//  Created by ROBERTO JUNIOR on 18/04/14.
//  Copyright (c) 2014 ROBERTO JUNIOR. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.loading startAnimating];
    self.logoImage.layer.borderWidth = 3.0f;
    self.logoImage.layer.cornerRadius = self.logoImage.frame.size.width/2;
    self.logoImage.clipsToBounds = YES;
    self.logoImage.layer.borderColor = [[UIColor whiteColor]CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}


@end
