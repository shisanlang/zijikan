//
//  ViewController.m
//  zijikan
//
//  Created by duan on 13-8-16.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#include <netdb.h>
#import "VideoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark view
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    
//    UIView *baseView = [[UIView alloc]init];
//    baseView.bounds = [UIScreen mainScreen].bounds;
//    
//    self.view = baseView;
//    [baseView release];
//    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
//    
//    [self presentModalViewController:navController animated:YES];
    
//    [UIApplication sharedApplication].delegate.httpServer;
    self.navigationItem.title = @"help";
    
    UILabel * PlaceLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 130, 240, 15)];
    PlaceLabel.text = @"123";//[self localIPAddress];
    PlaceLabel.textAlignment = UITextAlignmentCenter;
    PlaceLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:PlaceLabel];
    
    
    
    UIButton * but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(40, 20+44, 50, 20);
    [but setTitle:@"button" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    NSLog(@"%f,%f",self.view.frame.size.height,self.navigationController.view.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark do

- (void) next
{
    VideoViewController * vc = [[VideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ip

- (NSString *) hostname
{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '\0';
    
#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#endif
}

- (NSString *) localIPAddress
{
    struct hostent *host = gethostbyname([[self hostname] UTF8String]);
    if (!host) {herror("resolv"); return nil;}
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
}

@end
