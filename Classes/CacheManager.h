//
//  CacheManager.h
//  iRefletsInfo
//
//  Created by Jérôme Blondon on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+(CacheManager*) sharedCacheManager;

- (void)saveCache:(NSArray *)feeds slug:(NSString *)slug;
- (NSArray *) loadCache:(NSString *)slug;

@end

