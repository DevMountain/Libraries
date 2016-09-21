//
//  DMNLibrariesNetworkController.m
//  Libraries
//
//  Created by Andrew Madsen on 9/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import "DMNLibrariesNetworkController.h"
#import "DMNLibrary.h"

@implementation DMNLibrariesNetworkController

+ (DMNLibrariesNetworkController *)sharedController
{
	static DMNLibrariesNetworkController *sharedController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedController = [[self alloc] init];
	});
	return sharedController;
}

#pragma mark - Public

- (void)fetchResultsForSearchTerm:(NSString *)searchTerm completion:(void(^)(NSArray *results, NSError *error))completion
{
	NSURL *searchURL = [self apiURLForSearchTerm:searchTerm];
	NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		if (error) {
			NSLog(@"Error getting libraries.io search results for %@: %@", searchTerm, error);
			completion(nil, error);
			return;
		}
		
		NSError *localError = nil;
		NSArray *libraries = [self librariesByParsingJSONData:data error:&localError];
		completion(libraries, localError);
	}];
	[task resume];
}

#pragma mark - Private

+ (NSString *)apiKey
{
	static NSString *apiKey = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURL *apiKeysURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
		NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeysURL];
		apiKey = apiKeys[@"LibrariesAPIKey"];
	});
	return apiKey;
}

+ (NSURL *)baseURL
{
	return [NSURL URLWithString:@"https://libraries.io/"];
}

- (NSURL *)apiURLForSearchTerm:(NSString *)searchString
{
	NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:[[self class] baseURL] resolvingAgainstBaseURL:YES];
	urlComponents.path = @"/api/search";

	NSURLQueryItem *search = [NSURLQueryItem queryItemWithName:@"q" value:searchString];
	NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:[[self class] apiKey]];
	
	urlComponents.queryItems = @[search, apiKey];
	
	return urlComponents.URL;
}

#pragma mark - Parsing

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

@end
