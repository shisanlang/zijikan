//
//  VideoViewController.h
//  zijikan
//
//  Created by duan on 13-10-30.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoFrameExtractor;

@interface VideoViewController : UIViewController
{
    UIImageView *imageView;
    UILabel *label;
    UIButton *playButton;
    VideoFrameExtractor *video;
    float lastFrameTime;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) VideoFrameExtractor *video;

-(IBAction)playButtonAction:(id)sender;
- (IBAction)showTime:(id)sender;


@end
