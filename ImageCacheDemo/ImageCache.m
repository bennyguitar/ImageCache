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
        self.ImageOperationQueue = [[NSOperationQueue alloc] init];
        [self.ImageOperationQueue setMaxConcurrentOperationCount:5];
    }
	return self;
}

+(UIImage *)imageForKey:(NSString *)key {
    if ([ImageCache sharedCache].ImageDictionary[key]) {
        return [ImageCache sharedCache].ImageDictionary[key];
    }
    return nil;
}

+(void)setImage:(UIImage *)image forKey:(NSString *)key {
    [[ImageCache sharedCache].ImageDictionary setObject:image forKey:key];
}

+(void)addOperation:(NSOperation *)operation {
    [[ImageCache sharedCache].ImageOperationQueue addOperation:operation];
}

+(void)dumpCache {
    [ImageCache sharedCache].ImageDictionary = [@{} mutableCopy];
}

@end


#pragma mark - UIImageView Category
@implementation UIImageView (ImageCache)

-(void)setImageFromURL:(NSURL *)url {
    if ([ImageCache imageForKey:url.absoluteString]) {
        self.image = [ImageCache imageForKey:url.absoluteString];
    }
    else {
        ICOperation *operation = [[ICOperation alloc] init];
        __weak ICOperation *weakOp = operation;
        [operation setURL:url completion:^{
            if (weakOp.responseImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Success
                    self.image = weakOp.responseImage;
                    [ImageCache setImage:weakOp.responseImage forKey:url.absoluteString];
                });
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Failed
                    NSLog(@"Add Loading Image, or Failed to Load image here!");
                });
            }
        }];
        [ImageCache addOperation:operation];
    }
}

@end

#pragma mark - NSOperation Subclass
@implementation ICOperation

-(void)setURL:(NSURL *)url completion:(void (^)(void))block {
    self.url = url;
    self.completionBlock = block;
}

-(void)main {
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.url cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:10];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] init];
    UIImage *image = [UIImage imageWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]];
    if (image) {
        self.responseImage = image;
    }
}

@end