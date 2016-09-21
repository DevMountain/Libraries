//
//  DMNLibrariesNetworkController.h
//  Libraries
//
//  Created by Andrew Madsen on 9/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNLibrariesNetworkController : NSObject

@property (nonatomic, class, readonly) DMNLibrariesNetworkController *sharedController;

- (void)fetchResultsForSearchTerm:(NSString *)searchTerm completion:(void(^)(NSArray *results, NSError *error))completion;

@end
