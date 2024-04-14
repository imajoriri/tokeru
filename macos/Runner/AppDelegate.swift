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
      // 一度orderOutすることでステージマネージャーを使っている際に
      // 他のアプリケーションが隠れることを防いでいる。
      // 本来はapplicationShouldHandleReopenのreturnをfalseにすれば実現できるはずだがうまくいかないので
      // 代替案を使っている
      window.orderOut(nil)
      window.makeKeyAndOrderFront(nil)
    }
    return false
  }

  // accessoryにすることで、menu barが表示されない
  override func applicationDidFinishLaunching(_ notification: Notification) {
    // menu barあった方がショートカットキーを学習させられるので一旦コメントアウトする
    // 思い出しやすいようにコード自体は残す
    // NSApp.setActivationPolicy(.accessory)
  }
}
