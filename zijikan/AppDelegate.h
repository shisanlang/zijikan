//
//  AppDelegate.h
//  zijikan
//
//  Created by duan on 13-8-16.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKPasscodeLock.h"

//@class ViewController;
@class HTTPServer;

@interface AppDelegate : UIResponder <UIApplicationDelegate, KKPasscodeViewControllerDelegate>
{
    HTTPServer *httpServer;
}

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic) IBOutlet UINavigationController *navigationController;

@end
