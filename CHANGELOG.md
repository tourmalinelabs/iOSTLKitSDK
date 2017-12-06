# TLKit Change Log

## 11.0.17120500
* Telematics events monitoring.
* Improved stability.

## 10.3.17110301
* Improved stability.

## 10.1.17083000
* Improved stability.

## 10.1.17082500
* Improved stability.

## 10.0.17081400
* Despite major version bump there is no backwards compatibility changes.
* Significant improvement in routing algorithms.
* Stability improvements.
* Fixed bug where trip distance wasn't updated until the trip was complete. 

## 9.1.17072100
* Improved stability.

## 9.1.17071700
* Improved stability.
* Reduced network usage.

## 9.0.17062800
* Stability and bug fixes.

## 9.0.17061900
* SHA-256 hashes of emails now supported as user ids.
* Reworked  `CKContextKit` `init` methods remove need for standalone authorization 
  manager, eliminates seperate methods for starting in manual or automatic
  drive detection:

## 8.1.17051700
* Manual monitoring support
  * `CKContextKit` `initWithApiKey` becomes `initAutomaticWithApiKey` 
  * New init method is added: `initManualWithApiKey`
* Route computation improvements
* Battery usage optimizations

## 7.2.17041800
* Fix for merging of trips.
* Fix for some Timezone issues in LatAm with IOS.

## 7.0.17032801
* Fix where monitoring state was not properly initialzed.

## 7.0.17032300
* Initial release of TLKit.
