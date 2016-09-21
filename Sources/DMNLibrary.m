//
//  DMNLibrary.m
//  Libraries
//
//  Created by Andrew Madsen on 9/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import "DMNLibrary.h"

@implementation DMNLibrary

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [self init];
	if (self) {
		_name = dictionary[@"name"];
		_summary = dictionary[@"description"];
		_language = dictionary[@"language"];
		NSString *homepageURLString = dictionary[@"homepage"];
		if (homepageURLString) {
			_homepageURL = [NSURL URLWithString:homepageURLString];
		}
		_numberOfStars = [dictionary[@"stars"] unsignedIntegerValue];
	}
	return self;
}

@end
