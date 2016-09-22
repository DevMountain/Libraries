//
//  DMNSearchController.h
//  Libraries
//
//  Created by Andrew Madsen on 9/22/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const DMNSearchControllerResultsDidUpdateNotification;

@interface DMNSearchController : NSObject

- (void)searchForLibrariesMatching:(NSString *)searchString;
- (void)clearSearchResults;

@property (nonatomic, strong, readonly) NSArray *searchResults;

@end
