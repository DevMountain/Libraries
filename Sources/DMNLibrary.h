//
//  DMNLibrary.h
//  Libraries
//
//  Created by Andrew Madsen on 9/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNLibrary : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, readonly) NSString *language;
@property (nonatomic, readonly) NSURL *homepageURL;
@property (nonatomic, readonly) NSUInteger numberOfStars;

@end
