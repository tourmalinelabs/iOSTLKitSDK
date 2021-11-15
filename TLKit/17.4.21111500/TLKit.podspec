Pod::Spec.new do |s|
  s.name = "TLKit"
  s.version = "17.4.21111500"
  s.summary = "Driving Behavior, Scoring & Analytics | UBI | Mobile Device Telematics | Tracking | Always On Location"
  s.license = "Commercial"
  s.author = {"Eric Hall"=>"eric@tourmalinelabs.com"}
  s.homepage = 'http://tourmalinelabs.com'
  s.libraries = ["z", "stdc++"]
  s.requires_arc = true
  s.source = { :http => "https://s3.amazonaws.com/tlsdk-ios-stage-frameworks/TLKit-17.4.21111500.zip" }

  s.ios.deployment_target = '9.0'
  s.ios.vendored_framework = 'TLKit.framework'
  s.ios.frameworks = ["CFNetwork", "Security", "CoreMotion","CoreLocation","MobileCoreServices", "SystemConfiguration", "UIKit"]
end
