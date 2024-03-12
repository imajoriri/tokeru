import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    // falseにすることで、closeされてもバックグラウンドで動き続ける(アプリが終了しない)
    return false
  }

  /// docのアプリアイコンを押された時に表示する
  override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    for window in sender.windows {
      window.makeKeyAndOrderFront(nil)
    }
    return true
  }
}
