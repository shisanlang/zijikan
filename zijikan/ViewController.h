//
//  ViewController.h
//  zijikan
//
//  Created by duan on 13-8-16.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKPasscodeViewController.h"


@interface ViewController : UIViewController <KKPasscodeViewControllerDelegate>
{
    NSString * _passCode;
}
@end
