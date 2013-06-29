//
//  ViewController.h
//  ImageCacheDemo
//
//  Created by Benjamin Gordon on 6/29/13.
//  Copyright (c) 2013 Benjamin Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

- (IBAction)loadImage:(id)sender;

@end
