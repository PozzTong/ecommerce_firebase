import Flutter
import UIKit
// add more
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    self.window.secureApp()
    // add more
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)}

    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS, 10.0, *) {
      UNUserNotificationCenter.current().delegate= self as? UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension UIWindow {
  func secureApp(){
    let field=UITextField()
    field.isSecureTextEntry=true
    self.addSubview(field)
    field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
    field.centerXAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
    self.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayer?.first?.addSublayer(self.layer)
  }
  
}