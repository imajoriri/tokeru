import Cocoa
import FlutterMacOS

public class HapticsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "haptics", binaryMessenger: registrar.messenger)
    let instance = HapticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "hovered":
      let performer = NSHapticFeedbackManager.defaultPerformer
      performer.perform(.generic, performanceTime: .now)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
