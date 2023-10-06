import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyB2ww6WKWwtzou2Bd-n9srj8nmAuush-fY")
    GeneratedPluginRegistrant.register(with: self)
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs access to location when open.</string>
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
