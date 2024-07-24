import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    // falseにすることで、closeされてもバックグラウンドで動き続ける(アプリが終了しない)
    return false
  }

  // accessoryにすることで、menu barが表示されない
  override func applicationDidFinishLaunching(_ notification: Notification) {
    // menu barあった方がショートカットキーを学習させられるので一旦コメントアウトする
    // 思い出しやすいようにコード自体は残す
    // NSApp.setActivationPolicy(.accessory)
  }
}
