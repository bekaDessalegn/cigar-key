import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      UNUserNotificationCenter.current().delegate = self
      application.registerForRemoteNotifications()

    GeneratedPluginRegistrant.register(with: self)
      GMSServices.provideAPIKey("AIzaSyCokWiVaDt1XhQD_HEL-s2YaZbv8FTBDXs")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
