//
//  ViewController.h
//  ImageCacheDemo
//
//  Created by Benjamin Gordon on 6/29/13.
//  Copyright (c) 2013 Benjamin Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UITextField *dumpTextField;
@property (nonatomic, assign) int count;

- (IBAction)loadImage:(id)sender;
- (IBAction)didSelectDumpCache:(id)sender;

@end
