//
//  CacheManager.m
//  iRefletsInfo
//
//  Created by Jérôme Blondon on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager

static CacheManager *_sharedCacheManager = nil;


+(CacheManager *)sharedCacheManager
{
    @synchronized([CacheManager class]) 
    {
        if (!_sharedCacheManager)
            [[self alloc] init];
        return _sharedCacheManager;
    }
    return nil;
}

+(id)alloc 
{
    @synchronized([CacheManager class])
    {
        NSAssert(_sharedCacheManager == nil, @"Attempted to allocate a second instance of cache manager singleton");
        _sharedCacheManager = [super alloc];
        return _sharedCacheManager;
    }
    return nil;
}

-(id)init
{
    self = [super init];
    if (self != nil) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Public methods
- (void)saveCache:(NSArray *)feeds slug:(NSString *)slug
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filename = [[NSString alloc] initWithFormat:@"%@.data", slug];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
    NSLog(@"saving data to %@", filePath);
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feeds];
    BOOL res = [data writeToFile:filePath atomically:TRUE];
    if (!res) {
        NSLog(@"Error");
    }
    [filename release];
}

- (NSArray *) loadCache:(NSString *)slug
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filename = [[NSString alloc] initWithFormat:@"%@.data", slug];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    if (!data) {
        return nil;
    }
    NSArray *feeds = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [data release];
    [filename release];
    return feeds;
}


@end
