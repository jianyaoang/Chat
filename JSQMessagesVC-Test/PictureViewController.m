//
//  PictureViewController.m
//  JSQMessagesVC-Test
//
//  Created by Jian Yao Ang on 2/10/15.
//  Copyright (c) 2015 Jian Yao Ang. All rights reserved.
//

#import "PictureViewController.h"
#import <JSQPhotoMediaItem.h>

@interface PictureViewController () <UIScrollViewDelegate>

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *pictureURL = [NSURL URLWithString:@"http://bayfieldcoffeecompany.com/wp-content/uploads/2013/11/coffee1.jpeg"];
//    NSData *pictureData = [NSData dataWithContentsOfURL:pictureURL];
//    UIImage *thePicture = [UIImage imageWithData:pictureData];

    UIImage *jsqImage = self.photoMediaItem.image;
    
    self.theImageView.image = jsqImage;
    self.theImageView = [[UIImageView alloc] initWithImage:jsqImage];
    self.theImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.theImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self configureScrollView];
    [self whereIsTheURL];
    
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.theImageView;
}

-(void)configureScrollView
{
    self.theScrollView.delegate = self;
    self.theScrollView.minimumZoomScale = 1.0f;
    self.theScrollView.maximumZoomScale = 3.0f;
    self.theScrollView.contentMode = UIViewContentModeScaleAspectFit;
    self.theScrollView.contentSize = self.theImageView.bounds.size;
    self.theScrollView.clipsToBounds = YES;
    self.theScrollView.frame = self.theImageView.frame;
    [self.theScrollView setBackgroundColor:[UIColor blackColor]];
    [self.theScrollView addSubview:self.theImageView];
}

-(void)whereIsTheURL
{
    NSString *theString = @"Hello world! Check out https://youtube.com";
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [linkDetector matchesInString:theString options:0 range:NSMakeRange(0, [theString length])];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSURL *url = [match URL];
        NSLog(@"the url is : %@", url);
    }
}


@end
