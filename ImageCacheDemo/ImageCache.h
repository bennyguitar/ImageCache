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

+(ImageCache*)sharedCache;
-(void)setImageAtURL:(NSURL *)url forUIElement:(id)element;
-(UIImage *)imageForURLPath:(NSString *)path;
-(void)dumpCache;

@end
