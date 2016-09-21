//
//  DMNMainViewController.m
//  Libraries
//
//  Created by Andrew Madsen on 9/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import "DMNMainViewController.h"

@interface DMNMainViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DMNMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"LibraryCell"];
	
	return cell;
}

#pragma mark - UISearchBarDelegate



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
