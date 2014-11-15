Analytics-Sandbox
=================

sample app demonstrating how to get up and running with Google Tag Manager for iOS

######Quick Start

Add the latest Google Analytics Services SDK (which includes GTM) to your Xcode project using either of these options:

####Step 1. (with CocoaPods)
* add pod ‘GoogleTagManager’ to your app’s Podfile 
* run pod install in terminal from the project directory

####Step 1. (without CocoaPods)
* download the Google Analytics Services SDK <https://developers.google.com/analytics/devguides/collection/ios/resources>
* follow the instructions for Step #1 listed here: 
<https://developers.google.com/tag-manager/ios/v3/#add-sdk>

####Step 2. Add the default GTM container to your app’s bundle.  

* Download the container from the GTM web interface
* Rename the file to remove the appended version number (e.g. if the file you downloaded from GTM is named "GTM1234_v1” rename it to "GTM1234"
* Drag the downloaded file into your Xcode project (make sure “Copy if needed” is checked)

####Step 3. Open the default container:
* This step involves adding 2 properties to your AppDelegate, importing the necessary header files, then calling the openContainer…. method inside of AppDelegate’s application:didFinishLaunchingWithOptions: method
* Remember to pass your GTM container ID in this method
* If there’s any confusion on this step, refer to Google’s sample AppDelegate code here: <https://developers.google.com/tag-manager/ios/v3/#open-container>


####Step 4. Sending Hits to Google Analytics
* To start sending screen hits, you’ll just send a set of key-value pairs (NSDictionary) of the event including the event type  and a unique name for each screen in your ViewController’s viewDidAppear: method, like this:

```
TAGDataLayer *dataLayer = [[TAGManager instance] dataLayer]; 
NSDictionary *event = @{ @"event": @"screen", @"screen-name": @"Home Screen"}; 
[dataLayer push:event];
```

######Note

Depending on your App’s current architecture, your initial implementation could vary quite a bit.  For example, if your app only has a couple of screens, you can just add these dataLayer calls to each viewController’s viewDidAppear: method manually. 

If, however, your App’s has multiple screens, a non-linear flow, and/or dynamically generated screens, you might benefit from an approach like this:

* Add screen hit data layer push to the viewDidAppear: method of a superclass that all of your other viewControllers inherit from
* (alternately, you can method swizzle viewDidAppear: to accomplish the same thing)
* Set a meaningful, unique value for each screen’s accessibilityLabel
* Use the accessibilityLabel in your dataLayer push, like this:

```
TAGDataLayer *dataLayer = [[TAGManager instance] dataLayer];
NSDictionary *event = @{ @"event": @"screen", @"screen-name": self.view.accessibilityIdentifier};
[dataLayer push:event];
```

