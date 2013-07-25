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
    self.count = 0;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Function
-(NSString *)getURLString {
    self.count++;
    switch (self.count) {
        case 1:
            return @"http://newleaderscouncil.org/sanfrancisco/wp-content/uploads/2013/01/1.jpg";
            break;
        case 2:
            return @"http://mcmanuslab.ucsf.edu/sites/mcmanuslab.ucsf.edu/files/imagepicker/m/mmcmanus/1stPlaceSanFranciscoCableCars.jpg";
            break;
        case 3:
            return @"http://www.zanebenefits.com/Portals/149308/images/HCSO%20San%20Francisco.jpg";
            break;
        case 4:
            return @"http://images.nationalgeographic.com/wpf/media-live/photos/000/024/cache/sanfrancisco-lombard-street_2461_600x450.jpg";
            break;
        case 5:
            self.count = 0;
            return @"https://sphotos-b.xx.fbcdn.net/hphotos-ash3/p480x480/1014299_10151570057364219_1628249566_n.jpg";
            break;
        default:
            self.count = 0;
            return nil;
            break;
    }
}

#pragma mark - Load Image
- (IBAction)loadImage:(id)sender {
    [self.mainImageView setImageFromURL:[NSURL URLWithString:[self getURLString]]];
}

#pragma mark - Dump the (dumpTextField.text) Least Recently used in cache
- (IBAction)didSelectDumpCache:(id)sender {
    [ImageCache dumpLeastRecentlyUsed:[self.dumpTextField.text intValue]];
}

#pragma mark - TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [ImageCache dumpLeastRecentlyUsed:[self.dumpTextField.text intValue]];
    [textField resignFirstResponder];
    return YES;
}

@end
