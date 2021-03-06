Students will build an Objective-C app to search and view information about open source libraries using the libraries.io API. This project is primarily to gain experience using Objective-C. It includes MVC separation, use of REST APIs and JSON parsing, table views, segues, and other iOS core concepts.

### Part One - Model Objects

* Create custom model classes in Objective-C
* Implement the `-initWithDictionary:` pattern for initializing model objects from parsed JSON in ObjC

### Part Two - Networking and JSON

* Create a network controller in ObjC
* Use the shared instance pattern in ObjC using a class method and `dispatch_once()`
* Use `NSURLSession` to make REST API calls in ObjC
* Use `NSJSONSerialization` to parse JSON in ObjC

### Part Three - Search

* Create a controller used for searching and managing search results
* Add a `UISearchBar` to a view
* Manually respond to `UISearchBar` interactions to search and update results
* User GCD and `NSNotification`s in Objective-C to notify when search results have been updated

### Part Four - User Interface

* Implement a master-detail interface
* Declare conformance to and implement the `UITableViewDataSource` protocol in ObjC
* Create and use relationship segues
* Implement `-prepareForSegue:` in Objective-C

## Part One - Model Objects

### DMNLibrary

Create a `DMNLibrary` model class that will hold `name`, `summary`, `language`, `homepageURL`, and `numberOfStars` properties.

1. Add a new `DMNLibrary` class as an `NSObject` subclass (*Note*: In this README, the prefix `DMN` is used for all Objective-C classes. Feel free to use your own three-letter prefix instead.)
2. Add properties for `name`, `summary`, `language`, `homepageURL`, and `numberOfStars`.

### Black Diamonds

* Implement the `NSCoding` protocol on the `DMNLibrary` class.
* Create a Unit test that verifies `NSCoding` functionality by converting an instance to and from `NSData`.

## Part Two - Networking

*Preparation*: This project will use the [libraries.io API](https://libraries.io/api) to allow the user to search for and view information about open source libraries. In order to use the libraries.io API, you must register for an API key. Go to [libraries.io] and sign in using your GitHub account. From your [account page](https://libraries.io/account) find your API key. You'll need to include this in the URLs you use to get data from libraries.io.

### DMNLibrariesNetworkController

Create a network controller used to make requests against the libraries.io REST API.

1. Create a `DMNLibrariesNetworkController` class as a subclass of `NSObject`.
2. Create a `+sharedController` method to return a shared instance. 
    * note: Review the syntax for creating shared instances in Objective-C

```
+ (DMNLibrariesNetworkController *)sharedController
{
    static DMNLibrariesNetworkController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[DMNLibrariesNetworkController alloc] init];
    });
    return sharedController;
}
```

3. Create a `-fetchResultsForSearchTerm:completion:` method that takes a search string, searches for matching libraries using the libraries.io, and returns JSON data in an NSData using a passed in completion block.
	* note: Review the syntax for Objective-C blocks. See [http://goshdarnblocksyntax.com](http://goshdarnblocksyntax.com) for a handy reference.

### DMNLibrary JSON initialization

Add a dictionary initializer to `DMNLibrary`.

1. In `DMNLibrary`, add an initializer that takes an NSDictionary. The passed in dictionary will come from parsing JSON returned by the libraries API. Extract the appropriate values from the dictionary and use them to initialize a `DMNLibrary`.

### Testing

You will work on UI and the search functionality in the next two parts. In order to test your work, in your app delegate's `-applicationDidFinishLaunching:options:`, add code to retrieve JSON data using the network controller with a hardcoded search string ("AFNetworking" is a good choice), parse it using `NSJSONSerialization`, then create `DMNLibrary` instances from it. Log the results using `NSLog()` so you can be sure your networking code is working.

### Black Diamonds

* Add support for additional properties to `DMNLibrary`. The libraries.io API returns much more data than described here.
* Add unit tests to verify that `-[DMNLibrary initWithDictionary:]` works correctly.

## Part Three - Search

### DMNSearchController

Create a controller object whose purposes is to perform searches and maintain a list of search results. This is essentially a specialized model controller.

* Create a class called `DMNSearchController`.
* Add a property to contain an array of search results. It should be publicly readonly, but readwrite internally to the search controller (like `private(set)` in Swift).
* Add a method to search for libraries based on a passed in search string.
* Add a method to clear the list of search results.
* When the search results are updated, an `NSNotification` should be posted so that other parts of the app (e.g. UI controllers) can reload UI, etc.

## Part Four - User Interface

### DMNMainViewController

Create a main view controller with a search bar and a table view for displaying search results.

* Create a subclass of `UIViewController` called e.g. `DMNMainViewController`.
* In the storyboard, set this view controller up with a search bar at the top, and a table view underneath that.
* Make `DMNMainViewController` conform to the `UITableViewDataSource`, `UITableViewDelegate`, `UISearchBarDelegate` protocols.
* Connect appropriate outlets and actions need to populate the table view and to react to user-initiated searches in the search bar.
* Implement the `UITableViewDataSource` methods required to present a `DMNSearchController`'s search results in the table view.
* In `-viewDidLoad` register for the search results update notification you made `DMNSearchController` post. When this notification happens, reload the table view so that new search results are displayed.
* Implement the `UISearchBarDelegate` method `-searchBarSearchButtonClicked:` to initiate a new search when a user starts a new search using the search bar.

### DMNLibraryDetailViewController

Create a view controller to show details about a library when the user taps on it in the search results.

* Create a subclass of `UIViewController` called e.g. `DMNLibraryDetailViewController`.
* In the storyboard, add appropriate UI (labels, etc.) to show details about a specific library.
* Add a property called `library` used to control the library for which details are being shown.
* Create and implement a custom setter for the `library` property to make sure that the detail view controller's UI is updated in response to a new library being set.

### Storyboard Segue

* Create a show segue that is triggered when a row in the main view controller's table view is tapped. This segue should show the detail view controller. Give the segue an appropriate identifier.
* In `DMNMainViewController`, implement `-prepareForSegue:sender:` to get the appropriate `DMNLibrary` instance and pass it to the destination `DMNLibraryDetailViewController`.

### Black Diamonds

* In the detail view, make it so that the library's homepage URL is clickable and opens an `SFSafariViewController` with the library's homepage.

## Last Steps

Put your project on GitHub so it can be reviewed by your mentor.
