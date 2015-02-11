//
//  PictureViewController.h
//  JSQMessagesVC-Test
//
//  Created by Jian Yao Ang on 2/10/15.
//  Copyright (c) 2015 Jian Yao Ang. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <JSQPhotoMediaItem.h>

@interface PictureViewController : ViewController
@property (strong, nonatomic) UIImage *theImage;

@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) JSQPhotoMediaItem *photoMediaItem;
@property (strong, nonatomic) IBOutlet UIScrollView *theScrollView;

@end
