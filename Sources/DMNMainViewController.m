//
//  DMNMainViewController.m
//  Libraries
//
//  Created by Andrew Madsen on 9/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import "DMNMainViewController.h"
#import "DMNSearchController.h"
#import "DMNLibraryDetailViewController.h"
#import "DMNLibrary.h"

@interface DMNMainViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) DMNSearchController *searchController;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DMNMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.searchController = [[DMNSearchController alloc] init];
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self
		   selector:@selector(searchResultsDidUpdate:)
			   name:DMNSearchControllerResultsDidUpdateNotification 
			 object:nil];
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.searchController.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"LibraryCell" forIndexPath:indexPath];
	
	NSArray *results = self.searchController.searchResults;
	DMNLibrary *library = results[indexPath.row];
	
	cell.textLabel.text = library.name;
	
	return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	
	NSString *searchString = searchBar.text;
	[self.searchController clearSearchResults];
	[self.searchController searchForLibrariesMatching:searchString];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ShowLibraryDetail"]) {
		DMNLibraryDetailViewController *detailVC = segue.destinationViewController;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
		NSArray *libraries = self.searchController.searchResults;
		detailVC.library = libraries[indexPath.row];
	}
}

#pragma mark - Notifications

- (void)searchResultsDidUpdate:(NSNotification *)notification
{
	[self.tableView reloadData];
}

@end
