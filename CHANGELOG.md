# TLKit Change Log

## 15.6.20100100
* Improved stability.

## 15.5.20071700
* Improved stability.

## 15.5.20050400
* Improved stability.

## 15.3.20012900
* Improved stability.

## 15.3.20012800
* Improved stability.
* Added the ability to start a single manual drive.
* Added the ability to end all manual drives.

## 15.0.19110600
* Improved stability.

## 14.4.19100200
* Improved stability.

## 14.4.19080901
* Improved stability.

## 12.0.18061800
* Improved stability.

## 11.6.18052901
* Improved stability.

## 11.6.18052500
* Improved stability.

## 11.0.17121500
* Improved stability.

## 11.0.17121101
* Improved stability.

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
