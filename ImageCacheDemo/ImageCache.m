//
//  ImageCache.m
//  ImageCacheDemo
//
//  Created by Benjamin Gordon on 6/29/13.
//  Copyright (c) 2013 Benjamin Gordon. All rights reserved.
//  This class is based off of ideas/discussions with @MatthewYork
//

#import "ImageCache.h"

#define kTimeOutInterval 15

@implementation ImageCache
static ImageCache * _sharedCache = nil;

+(ImageCache*)sharedCache; {
	@synchronized([ImageCache class]) {
		if (!_sharedCache) {
            _sharedCache  = [[ImageCache alloc] init];
        }
		return _sharedCache;
	}
	
	return nil;
}

+(id)alloc {
	@synchronized([ImageCache class]) {
		NSAssert(_sharedCache == nil, @"Attempted to allocate a second instance of the ImageCache");
		_sharedCache = [super alloc];
		return _sharedCache;
	}
	
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
        self.ImageDictionary = [@{} mutableCopy];
	}
	
	return self;
}

#pragma mark - Set Image method
-(void)setImageAtURL:(NSURL *)url forUIElement:(id)element {
    if (self.ImageDictionary) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            if (self.ImageDictionary[url.path]) {
                // Image already exists
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setImage:self.ImageDictionary[url.path] forUIElement:element];
                });
            }
            else {
                // Image doesn't exist.
                // Let's load it from the Web
                NSURLResponse *response;
                NSError *error;
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:kTimeOutInterval];
                
                // Start the request
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                
                if (responseData) {
                    // We got data!
                    UIImage *image = [[UIImage alloc] initWithData:responseData];
                    if (image) {
                        // Set into Cache
                        [self.ImageDictionary setObject:image forKey:url.path];
                        // Update UI Element
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self setImage:image forUIElement:element];
                        });
                    }
                }
            }
        });
    }
}

#pragma mark - Getting the Image w/o setting a UIElement
-(UIImage *)imageForURLPath:(NSString *)path {
    if (self.ImageDictionary[path]) {
        return self.ImageDictionary[path];
    }
    else {
        [self setImageAtURL:[NSURL URLWithString:path] forUIElement:nil];
        return nil;
    }
}


#pragma mark - Private Helper
-(void)setImage:(UIImage *)image forUIElement:(id)element {
    if (element && image) {
        if ([element isKindOfClass:[UIImageView class]]) {
            [(UIImageView *)element setImage:image];
        }
        else if ([element isKindOfClass:[UITableView class]]) {
            [(UITableView *)element reloadData];
        }
        else if ([element isKindOfClass:[UICollectionView class]]) {
            [(UICollectionView *)element reloadData];
        }
        else if ([element isKindOfClass:[UIButton class]]) {
            [(UIButton *)element setImage:image forState:UIControlStateNormal];
        }
    }
}


#pragma mark - Dump Cache
-(void)dumpCache {
    self.ImageDictionary = [@{} mutableCopy];
}



@end
