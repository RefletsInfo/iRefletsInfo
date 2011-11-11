/*
 This module is licensed under the MIT license.
 
 Copyright (C) 2011 by raw engineering
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  MessageModel.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "MessageModel.h"
#define kMessageIDKey      @"id"
#define kContentKey        @"content"
#define kCreatedAtKey      @"created_at"
#define kUserName          @"userName"
#define kUserImage         @"userImage"


@implementation MessageModel

@synthesize messageID;
@synthesize content;
@synthesize createdAt;
@synthesize userName;
@synthesize userImage;

-(id)initWithMessageObject:(NSDictionary*)messageObject {
	if (self = [super init]) {
		self.messageID = (NSInteger)[[messageObject objectForKey:kMessageIDKey] intValue];
		self.content = [messageObject objectForKey:kContentKey];
		self.createdAt = [messageObject objectForKey:kCreatedAtKey];
		self.userName = [messageObject objectForKey:kUserName];
		self.userImage = [messageObject objectForKey:kUserImage];
	}
	return self;
}


- (void) dealloc {
	[content release];
	[createdAt release];
	[userName release];
	[userImage release];
	[super dealloc];
}

#pragma mark - NSCoding
#pragma mark NSCoding


- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:messageID forKey:kMessageIDKey];
    [encoder encodeObject:content forKey:kContentKey];
    [encoder encodeObject:createdAt forKey:kCreatedAtKey];
    [encoder encodeObject:userName forKey:kUserName];
    [encoder encodeObject:userImage forKey:kUserImage];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    id msgId = [decoder decodeObjectForKey:kMessageIDKey];
    
    if (msgId) {
        [dict setObject:msgId forKey:kMessageIDKey];
    }
    [dict setObject:[decoder decodeObjectForKey:kContentKey] forKey:kContentKey];
    [dict setObject:[decoder decodeObjectForKey:kCreatedAtKey] forKey:kCreatedAtKey];
    [dict setObject:[decoder decodeObjectForKey:kUserName] forKey:kUserName];
    [dict setObject:[decoder decodeObjectForKey:kUserImage] forKey:kUserImage];
    id res = [self initWithMessageObject:dict];
    [dict release];
    return res;
}

@end
