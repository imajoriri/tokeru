import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class MainFlutterWindow: NSWindow {
  var flutterViewController: FlutterViewController!
  var channelMethod: FlutterMethodChannel!
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)
  var panel: FloatingPanel!

  /// ウィンドウのサイズと位置を設定する
  func setDefaultWindow() {
    // ウィンドウのサイズを設定
    let windowSize = NSSize(width: 1000, height: 800)

    // スクリーンのサイズを取得
    // `NSScreen.screens.first`はアプリを最初に開いた画面
    guard let screen = NSScreen.screens.first else { return }
    let screenSize = screen.frame.size

    // Xはウィンドウの中心
    let x = (screenSize.width - windowSize.width) / 2
    // Yはウィンドウの中心よりやや上
    let y = ((screenSize.height - windowSize.height) / 2) + 100

    // ウィンドウの位置とサイズを設定して表示
    self.setFrame(NSRect(x: x, y: y, width: windowSize.width, height: windowSize.height), display: true)
  }

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    self.setDefaultWindow()

    // タイトルを非表示にする
    let customToolbar = NSToolbar()
    self.toolbar = customToolbar
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true

    self.styleMask.insert(.fullSizeContentView)

    // 画面どこを持っても移動できるようにする
    self.isMovable = true
    self.isMovableByWindowBackground = true

    channelMethod = FlutterMethodChannel(name: "quick.flutter/window", binaryMessenger: flutterViewController.engine.binaryMessenger)
    setupNotification()
    setHandler()
    createPanel()

    super.awakeFromNib()
  }

  private func setupNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleDidBecomeKeyNotification(_:)), name: NSWindow.didBecomeKeyNotification, object: self)
    NotificationCenter.default.addObserver(self, selector: #selector(handleDidResignKeyNotification(_:)), name: NSWindow.didResignKeyNotification, object: self)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  // ウィンドウがキーウィンドウになった時の処理を行う
  @objc private func handleDidBecomeKeyNotification(_ notification: Notification) {
    channelMethod.invokeMethod("active", arguments: nil)
  }

  // ウィンドウが非アクティブになった時の処理
  @objc private func handleDidResignKeyNotification(_ notification: Notification) {
    channelMethod.invokeMethod("inactive", arguments: nil)
  }


  func setHandler() {
    // Flutter側でのイベントを受け取る
    channelMethod.setMethodCallHandler { (call, result) in
      switch call.method {
      case "openPanel":
        self.openPanel()
        return
      case "quit":
        self.quit()
      default:
        result(FlutterMethodNotImplemented)
        return
      }
    }
  }

  /// FloatingPanelを作成する。
  ///
  /// [opePanel]メソッドを呼ぶことでユーザーが見えるように表示する
  func createPanel() {
    flutterEngine.run(withEntrypoint: "panel");
    let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)

    panel = FloatingPanel(flutterViewController: flutterViewController)
    panel.contentView = flutterViewController.view
    panel.contentViewController = flutterViewController
    RegisterGeneratedPlugins(registry: flutterViewController)
  }

  /// FloatingPanelを表示する。
  func openPanel() {
    panel.orderFront(nil)
    panel.makeKey()
  }

  /// アプリケーションを終了する。
  func quit() {
    NSApplication.shared.terminate(nil)
  }
}

