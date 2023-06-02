# Migration guide from TLKit 17.x.xyz to TLKit 22.x.xyz

## TLKit renaming

The `CKContextKit` is now called `TLKit`.
You still have access to the previous functions. 
For example:

- `TLKit.isInitialized`
- `[TLKit initWithApiKey:...];`

## Initialization

Because of `TLKit` integration, your app will be able to automatically restart in background in different circumstances: significant location changes, device reboot, an app update, a crash... 
When the app starts the AppDelegate 

`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions` 

method is called. It is the integrator responsability to know if `TLKit` was previously running.
If that was the case you must call `[TLKit initWithApiKey:...]` to reauthenticate the user.
That is very important to call `[TLKit initWithApiKey:...]` as quickly as possible to ensure that the keep alive mechanism is effectively set before iOS decides to kill the app. 
You must not defer the initialization because you need a network reponse or you wait another thread to dispatch some information.

For being able to do that you will probably have to store locally all the starting parameters you need like:
- the user identifier
- the group identifier to join in case you use the `TLLaunchOptions`
- ...

Here is the new initialization method:

```objc
[TLKit initWithApiKey:apiKey
                  area:TLCloudAreaUS
              hashedId:[TLDigest sha256:@"iosexample@tourmalinelabs.com"]
           authHandler:^(TLAuthenticationStatus status, NSError *_Nullable error) {...}
                  mode:TLMonitoringModeAutomatic
         launchOptions:launchOptions
     withResultToQueue:queue
           withHandler:^(BOOL successful, NSError * _Nullable error) {...}];
```

The 2 main differences are:

- You have to specify the `TLCloudArea`, the default one should always be the US area `TLCloudAreaUS`. If you have been told to do so use the european area `TLCloudAreaEU` instead.

- The new `TLAuthenticationStatusHandler` will allow you to get a feedback about the authentication status. For example if you choose to initialize `TLKit` with a username and a password and you provide a wrong password this handler will return an error.

## TL Prefix

All the enums, interfaces, managers, defined blocks... are now prefixed with `TL`.

For example:

- `TLMonitoringMode`
- `TLLaunchOptions`
- `TLActivityManager`
- `TLCompletionListener`

## 'Drive' has been replaced by 'Trip'

The word Drive has been banished and replaced by the word Trip in all places.

## Suscribing to specific events

Event subscriptions are made by a call to functions starting with `listenForXYZToQueue`. 

For example:

```objc
- (void)listenForTripEventsToQueue:(nullable dispatch_queue_t)queue
                       withHandler:(TLActivityEventHandler)handler;
```