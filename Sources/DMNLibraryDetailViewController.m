//
//  DMNLibraryDetailViewController.m
//  Libraries
//
//  Created by Andrew Madsen on 9/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

#import "DMNLibraryDetailViewController.h"
#import "DMNLibrary.h"

@interface DMNLibraryDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *languageLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfStarsLabel;
@property (strong, nonatomic) IBOutlet UILabel *homepageLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;

@end

@implementation DMNLibraryDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self updateViews];
}

#pragma mark - Private

- (void)updateViews
{
	if (!self.isViewLoaded) { return; }
	
	self.languageLabel.text = self.library.language;
	self.numberOfStarsLabel.text = [NSString stringWithFormat:@"%@ Stars", @(self.library.numberOfStars)];
	NSDictionary *linkAttributes = @{NSLinkAttributeName : self.library.homepageURL};
	NSAttributedString *linkString = [[NSAttributedString alloc] initWithString:[self.library.homepageURL absoluteString]
																	 attributes:linkAttributes];
	self.homepageLabel.attributedText = linkString;
	self.summaryLabel.text = self.library.summary;
}

#pragma mark - Properties

- (void)setLibrary:(DMNLibrary *)library
{
	if (library != _library) {
		_library = library;
		[self updateViews];
	}
}

@end
