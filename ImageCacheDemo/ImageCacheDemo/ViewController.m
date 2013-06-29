//
//  ViewController.m
//  ImageCacheDemo
//
//  Created by Benjamin Gordon on 6/29/13.
//  Copyright (c) 2013 Benjamin Gordon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadImage:(id)sender {
    [[ImageCache sharedCache] setImageAtURL:[NSURL URLWithString:@"http://newleaderscouncil.org/sanfrancisco/wp-content/uploads/2013/01/1.jpg"] forUIElement:self.mainImageView];
}


@end
