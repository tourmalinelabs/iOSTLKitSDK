# TLKit Change Log

# 7.0

## 7.0.17032300

* Initial release of TLKit.

## 7.2.17041800
* Fix for merging of trips.
* Fix for some Timezone issues in LatAm with IOS.

# 8.0
8.0 introduces manual drive tracking, in addition to the existing automatic 
drive detection and monitoring. Manual tracking addresses use cases where the
user interacts with an application to explicity tell it when drives had started
and stopped, such as ride sharing apps.

## 8.0.17042802 
Initial 8.0 release.

New initialization apis

`CKContextKit.h`:

```objc
/**
 * Initialize engine with a registered user for manual activity tracking
 *
 * @param apiKey The API key for provisioned for this app.
 * @param authMgr CKAuthenticationManagerDelegate to be used for token retrieval
 * @param launchOpts Launchoptions supplied at application launch
 * @param q The dispatch queue that will receive the callback upon completion
 * @param hndlr CKCompletionHandler Completion handler called upon success or failure
 */
+ (void)initManualWithApiKey:(NSString *)apiKey
                     authMgr:(id <CKAuthenticationManagerDelegate>)authMgr
               launchOptions:(nullable NSDictionary *)launchOpts
           withResultToQueue:(nullable dispatch_queue_t)q
                 withHandler:(CKCompletionHandler)hndlr;
/**
 * Initialize engine with a registered user for automatic activity detection.
 *
 * @param apiKey The API key for provisioned for this app.
 * @param authMgr CKAuthenticationManagerDelegate to be used for token retrieval
 * @param launchOpts Launchoptions supplied at application launch
 * @param q The dispatch queue that will receive the callback upon completion
 * @param hndlr CKCompletionHandler Completion handler called upon success or failure
 */
+ (void)initAutomaticWithApiKey:(NSString *)apiKey
                        authMgr:(id <CKAuthenticationManagerDelegate>)authMgr
                  launchOptions:(nullable NSDictionary *)launchOpts
              withResultToQueue:(nullable dispatch_queue_t)q
                    withHandler:(CKCompletionHandler)hndlr;
```

New manual start stop apis

`CKActivityManager.h`:

```objc

/**
 * Will start monitoring a trip with the specified id. Will continue
 * monitoring the trip until StopMonitoring is called with the same id.
 *
 * Can be called multiple times to trap multiple overlapping trips
 * simultaneously.
 */
-(NSUUID*)startManualTrip;

/**
 * Stop monitoring a trip with the with the specified id.
 *
 * @param id of trip to be stopped.
 */
-(void)stopManualTrip:(NSUUID *)tripId;

-(void)queryManualTripstoQueue:(nullable dispatch_queue_t)q
                   withHandler:(CKActivityQueryHandler)hndlr;

```
