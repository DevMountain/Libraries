//
//  DMNSearchController.m
//  Libraries
//
//  Created by Andrew Madsen on 9/22/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import "DMNSearchController.h"
#import "DMNLibrariesNetworkController.h"
#import "DMNLibrary.h"

NSString * const DMNSearchControllerResultsDidUpdateNotification = @"DMNSearchControllerResultsDidUpdateNotification";

@interface DMNSearchController ()

@property (nonatomic, strong, readwrite) NSArray *searchResults;

@end

@implementation DMNSearchController

#pragma mark - Public

- (void)searchForLibrariesMatching:(NSString *)searchString
{
	DMNLibrariesNetworkController *networkController = [DMNLibrariesNetworkController sharedController];
	[networkController fetchResultsForSearchTerm:searchString completion:^(NSData *jsonData, NSError *error) {
		if (error) {
			NSLog(@"Error getting search results: %@", error);
			return;
		}
		
		NSError *localError = nil;
		NSArray *results = [self librariesByParsingJSONData:jsonData error:&localError];
		if (!results) {
			NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
			NSLog(@"Error parsing JSON for search %@: %@", jsonString, error);
		}
		
		self.searchResults = results;
	}];
}

- (void)clearSearchResults
{
	self.searchResults = nil;
}

#pragma mark - Private

#pragma mark Parsing

- (NSArray *)librariesByParsingJSONData:(NSData *)data error:(NSError **)error
{
	error = error ?: &(NSError *__autoreleasing){ nil };
	NSArray *dictionaries = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
	if (!dictionaries) { return nil; }
	
	NSMutableArray *libraries = [NSMutableArray array];
	for (NSDictionary *dictionary in dictionaries) {
		DMNLibrary *library = [[DMNLibrary alloc] initWithDictionary:dictionary];
		if (library) {
			[libraries addObject:library];
		}
	}
	return libraries;
}

#pragma mark - Properties

- (void)setSearchResults:(NSArray *)searchResults
{
	if (searchResults != _searchResults) {
		_searchResults = searchResults;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
			[nc postNotificationName:DMNSearchControllerResultsDidUpdateNotification object:self];
		});
	}
}

@end
