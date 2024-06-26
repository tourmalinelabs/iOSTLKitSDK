Pod::Spec.new do |s|
  s.name = "TLKit"
  s.version = "23.0.24052900"
  s.summary = "Driving Behavior, Scoring & Analytics | UBI | Mobile Device Telematics | Tracking | Always On Location"
  s.license = "Commercial"
  s.author = {"Eric Hall"=>"eric@tourmalinelabs.com"}
  s.homepage = 'http://tourmalinelabs.com'
  s.libraries = ["z", "stdc++"]
  s.requires_arc = true
  s.source = { :http => "https://s3.amazonaws.com/tlsdk-ios-stage-frameworks/TLKit-23.0.24052900.zip" }

  s.ios.deployment_target = '9.0'
  s.ios.vendored_framework = 'TLKit.xcframework'
  s.ios.frameworks = ["CFNetwork", "Security", "CoreMotion","CoreLocation","MobileCoreServices", "SystemConfiguration", "UIKit"]
end
