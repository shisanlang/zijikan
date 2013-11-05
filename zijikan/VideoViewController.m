//
//  VideoViewController.m
//  zijikan
//
//  Created by duan on 13-10-30.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoFrameExtractor.h"
#import "Utilities.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

@synthesize imageView, label, playButton, video;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //
    label = [[UILabel alloc]initWithFrame:CGRectMake(258, 446, 42, 21)];
    label.text = @"fps";//[self localIPAddress];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    
    
    
    playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playButton.frame = CGRectMake(35, 440, 58, 35);
    [playButton setTitle:@"play" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    UIButton * timeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    timeButton.frame = CGRectMake(131, 440, 58, 35);
    [timeButton setTitle:@"time" forState:UIControlStateNormal];
    [timeButton addTarget:self action:@selector(showTime:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeButton];
    
    NSLog(@"%f,%f",self.view.frame.size.height,self.navigationController.view.frame.size.height);
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-53, 53, 426, 320)];
    [self.view addSubview:imageView];
    //
    
    
    
    self.video = [[VideoFrameExtractor alloc] initWithVideo:[Utilities bundlePath:@"1.flv"]];//sophie.mov
//	[video release];
    
	// set output image size
	video.outputWidth = 426;
	video.outputHeight = 320;
	
	// print some info about the video
	NSLog(@"video duration: %f",video.duration);
	NSLog(@"video size: %d x %d", video.sourceWidth, video.sourceHeight);
	
	// video images are landscape, so rotate image view 90 degrees
	[imageView setTransform:CGAffineTransformMakeRotation(M_PI/2)];
}

-(IBAction)playButtonAction:(id)sender {
	[playButton setEnabled:NO];
	lastFrameTime = -1;
	
	// seek to 0.0 seconds
	[video seekTime:0.0];
    
	[NSTimer scheduledTimerWithTimeInterval:1.0/30
									 target:self
								   selector:@selector(displayNextFrame:)
								   userInfo:nil
									repeats:YES];
}

- (IBAction)showTime:(id)sender {
    NSLog(@"current time: %f s",video.currentTime);
}

#define LERP(A,B,C) ((A)*(1.0-C)+(B)*C)

-(void)displayNextFrame:(NSTimer *)timer {
	NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
	if (![video stepFrame]) {
		[timer invalidate];
		[playButton setEnabled:YES];
		return;
	}
	imageView.image = video.currentImage;
	float frameTime = 1.0/([NSDate timeIntervalSinceReferenceDate]-startTime);
	if (lastFrameTime<0) {
		lastFrameTime = frameTime;
	} else {
		lastFrameTime = LERP(frameTime, lastFrameTime, 0.8);
	}
	[label setText:[NSString stringWithFormat:@"%.0f",lastFrameTime]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
