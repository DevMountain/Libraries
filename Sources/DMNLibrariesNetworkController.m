//
//  DMNLibrariesNetworkController.m
//  Libraries
//
//  Created by Andrew Madsen on 9/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import "DMNLibrariesNetworkController.h"

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

- (void)fetchResultsForSearchTerm:(NSString *)searchTerm completion:(void(^)(NSData *jsonData, NSError *error))completion
{
	NSURL *searchURL = [self apiURLForSearchTerm:searchTerm];
	NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		completion(data, error);
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
		if (!apiKeysURL) {
			NSLog(@"Error! APIKeys file not found!");
			return;
		}
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

@end
