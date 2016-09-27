Students will build an Objective-C app to search and view information about open source libraries using the libraries.io API. This project is primarily to gain experience using Objective-C. It includes MVC separation, use of REST APIs and JSON parsing, table views, segues, and other iOS core concepts.

### Part One - Model Objects and Networking

* Create custom model classes in Objective-C
* Create a network controller in ObjC
* Use the shared instance pattern in ObjC using a class method and `dispatch_once()`
* Use `NSURLSession` to make REST API calls in ObjC
* Use `NSJSONSerialization` to parse JSON in ObjC
* Implement the `-initWithDictionary:` pattern for initializing model objects from parsed JSON in ObjC

### Part Two - User Interface

* Implement a master-detail interface
* Declare conformance to and implement the `UITableViewDataSource` protocol in ObjC
* Create and use relationship segues
* Implement `-prepareForSegue:` in Objective-C

### Part Three - Search

* Create a controller used for searching and managing search results
* Add a `UISearchBar` to a view
* Manually respond to `UISearchBar` interactions to search and update results
* User GCD and `NSNotification`s in Objective-C to notify when search results have been updated