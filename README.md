# Getting started with TLKit for iOS

This document contains a quick start guide for integrating `TLKit` 
into your iOS application. More detailed documentation of the APIs can 
be found in the `docs` folder. The API documents can be opened by 
opening the file `docs/index.html` in your web browser.

# Sample Project

Checkout our sample project `CKExample` for a simple working example of 
how developers can use `TLKit`.

# Integrating TLKit framework into a project

## Option 1: CocoaPods

We recommand installing `TLKit` using [CocoaPods](http://cocoapods.org/), which provides a simple dependency management system that automates the error-prone process of manually configuring libraries. First make sure you have `CocoaPods` installed (you will also need to have Ruby installed):

```
sudo gem install cocoapods
pod setup
```

Now create an empty file in the root of your project directory, and name it `Podfile` or just run the following command:

```
pod init
```

Open and edit the `Podfile` as follow:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/tourmalinelabs/iOSTLKitSDK.git'

platform :ios, '9.0'

use_frameworks!

pod 'TLKit'
...
```

Finally, save and close the `Podfile` and run `pod install` to setup your `CocoaPods` environment and import `TLKit` into your project. Make sure to start working from the `.xcworkspace` file that `CocoaPods` automatically creates, not the `.xcodeproj` you may have had open.

That's it! You can start coding!

## Option 2: Manual installation

Instructions provided by Apple for adding an existing framework can be found 
[here](https://developer.apple.com/library/ios/recipes/xcode_help-structure_navigator/articles/Adding_a_Framework.html).

The `TLKit.framework` can also be dragged into an XCode project.

### Dependent frameworks

In project configuration under
`General > Linked Frameworks and Libraries` add the following 
dependencies

* `TLKit.framework`
* `SystemConfiguration.framework`
* `CoreMotion.framework`
* `CoreLocation.framework`
* `Security.framework`
* `libstdc++.tbd`
* `libz.tbd`

### Linking  

For each target using `TLKit`, in the configuration under
`Build Settings > Other Linker Flags` make sure the following flags are 
set `-lm -all_load -ObjC`

If you see a lot of errors related to linking, it is possible that 
`libc++` is not being linked for you. To solve this either change one 
file extension from `.m` to `.mm` or add a new empty `c++` file to the 
project.

## Configure Background Modes

Under `Capabilities > Background Modes` check the box next to 
`Location Updates` 

# Using TLKit

The heart of the `TLKit` is the Context Engine named `CKContextKit`. The engine needs to 
be initialized with a registered user in order to use any of its 
features. 

## Registering and authenticating users.

`CKContextKit` needs to be started in order to use any of its features and
starting `CKContextKit` requires an authentication token from the `TLKit`
server.

In a production environment authentication should be done between the
Application Server and the `TLKit` server. This will prevent the API
secret from being leaked out as part of SSL proxying attack on the mobile 
device. See the Data Services API on how to register and authenticate a 
user.

For initial integration and evaluation purposes we provide user 
registration and authentication services in the SDK. To register 
a user use do the following:

Starting and stopping the SDK is documented in the next section.

## Starting, Stopping CKContextKit

For evaluation purposes we provide the `simpleInitWithApiKey:` method which 
registers with the server on behalf of the developer, this is an 
insecure method of registration and a production implementation would 
use the regular `initWithApiKey` method.

An example of initializing the engine is provided here:

```objc 
#import <TLKit/CKContextKit.h>
...

[CKContextKit simpleInitWithApiKey:@"apiKey" 
                              user:@"foouser@bw.io"
                              pass:@"password"
                     launchOptions:nil
                 withResultToQueue:dispatch_get_main_queue()
                       withHandler:^(BOOL successful, NSError *error) {
                           if (error) {
                               NSLog(@"Failed to start ContextKit with error: %@",
                                   error);
                               return;
                           }
                           NSLog(@"Started ContextKit!");
                           ...
                       }];
```     

`CKContextKit` attempts to validate permissions and see other necessary 
conditions are met when starting the engine. If any of these conditions 
are not met it will fail with an `error` that can be used to debug the 
issue.

One example of where a failure would occur would be location permissions
not being enabled for the application.

`CKContextKit` can be stopped when it is not needed as follows:

```objc
[CKContextKit stopWithResultToQueue:dispatch_get_main_queue()
                        withHandler:^(BOOL successful, NSError *error) {
                            if (error) {
                                NSLog(@"Stopping Contextkit Failed: %@", 
                                    error);
                                return;
                            }
                            NSLog(@"Stopped ContextKit!");
                        }];
```

### Pre-authorize Location Manager access

`CKContextKit` utilizes GPS as one of it's context sensor. As such it is 
best practice to request "Always" authorization from the user for 
accesssing location prior to starting the engine.

## Drive Monitoring

Drive monitoring functionality is accessed through the 
`CKActivityManager`

```objc
self.actMgr = [CKActivityManager new];
```

### Starting, Stopping drive monitoring

Register a listener with the drive monitoring service as follows.

```objc
[self.actMgr 
    startDriveMonitoringWithTelematicsToQueue:dispatch_get_main_queue()
                                  withHandler:^(CKActivityEvent *evt, NSError * err) {
                                      // Update UI
                                      [weakSelf updateDataSource];
                                      NSLog(@"Drive event: %@", evt);
                                  }];
```

If this is the first registration by your app it will start drive 
monitoring.

_Note_: multiple drive events may be received for the same drive as the drive 
progresses and the drive processing updates the drive with more accurate map 
points.

Drive events can be stopped as follows

```objc
[self.actMgr stopDriveMonitoring];
```

If this was the last registration by your app it will stop drive 
monitoring.

### Querying previous drives 
Once started all drives will be recorded for querying either by date:

```objc
#import <TLKit/CKContextKit.h>
...

[self.actMgr queryDrivesFromDate:[NSDate distantPast]
                          toDate:[NSDate distantFuture]
                       withLimit:100
                         toQueue:dispatch_get_main_queue()
                     withHandler:^(NSArray *drives, NSError *error) {
                         if (!error) {
                             NSLog(@"Got drives: %@", drives);
                         }
                     }];
```    

or by id:

```objc    
NSUUID *driveId = ...;
[actMgr queryDriveById:driveId
               toQueue:dispatch_get_main_queue() 
           withHandler:^(NSArray *drives, NSError *err) {
               if (!error) {
                   NSLog(@"Found drive %@", drives[0]);
               }
           }];
```   

## Low power location monitoring

`TLKit` provides its own location manager class `CKLocationManager` which 
provides low power location monitoring.

Instantiation of the manager is as follows.

```objc
#import <TLKit/CKContextKit.h>
...
CKLocationManager *locMgr = [CKLocationManager new];
```

### Registering for location updates

An example of using the manager to receive location updates is provided below.

A listener must be registered to begin receiving location updates as follows:

```objc
[locMgr startUpdatingLocationsToQueue:dispatch_get_main_queue()
                          withHandler:^(CKLocation *location) {
                              NSLog(@"New location update %@", [location description]);
                          } 
                           completion:^(BOOL successful, NSError* error) {
                               if (successful) {
                                   NSLog(@"Started Location updates!");
                               }
                          }];
```

A listener can be unregistered as follows:

```objc
[locMgr stopUpdatingLocation];
```    

`TLKit` will monitor all location activity of the device while at
least one listener is registered. If no listeners are registered locations
will not be tracked or recorded.

### Querying location history

`CKLocationManager` provides the ability to query past locations via 
`queryLocations` method. The query locations method can be used as follows:

```objc    
[locMgr queryLocationsFromDate:[NSDate distantPast]
                        toDate:[NSDate distantFuture]
                     withLimit:30
                       toQueue:dispatch_get_main_queue()
                   withHandler:^(NSArray *locs, NSError *error ) {
                       NSLog( @"DB Query Result:" );
                       for ( id l in locs ) { NSLog(@"%@\n", l); }
                   }];
```

_Note_: This will only include locations that were recorded while a listener
was registered as stated in the previous section.

## Fleet management

`TLKit` also provides some powerful fleet management tools available 
through `CKFleetManager`. 

To manage drivers they must be registered and part of at least one 
group. Simple registration is covered above. Accepting invitations, 
joning groups, leaving groups, configuring vehicle classes and duty 
schedules can all be done via the `CKFleetManager` class.
