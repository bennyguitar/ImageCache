//
//  ImageCache.h
//  ImageCacheDemo
//
//  Created by Benjamin Gordon on 6/29/13.
//  Copyright (c) 2013 Benjamin Gordon. All rights reserved.
//  This class is based off of ideas/discussions with @MatthewYork
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject
@property (nonatomic, retain) NSMutableDictionary *ImageDictionary;
@property (nonatomic, retain) NSOperationQueue *ImageOperationQueue;
+(ImageCache*)sharedCache;
+(UIImage *)imageForKey:(NSString *)key;
+(void)setImage:(UIImage *)image forKey:(NSString *)key;
+(void)addOperation:(NSOperation *)operation;
+(void)dumpCache;
@end


@interface UIImageView (ImageCache)
-(void)setImageFromURL:(NSURL *)url;
@end


@interface ICOperation : NSOperation
@property (nonatomic, retain) UIImage *responseImage;
@property (nonatomic, retain) NSURL *url;
-(void)setURL:(NSURL *)url completion:(void (^)(void))block;
@end