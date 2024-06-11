import UIKit
import Flutter
import GoogleMaps
import Firebase
import AppTrackingTransparency


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()

     GMSServices.provideAPIKey("AIzaSyC_-QEoMjifhaoXliUxgOHlS5USjHONfCA")
       if #available(iOS 10.0, *) {
           UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
         }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

   override func applicationDidBecomeActive(_ application: UIApplication) {
          if #available(iOS 14, *) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          ATTrackingManager.requestTrackingAuthorization { status in
                  }
              }
          }
      }
}
