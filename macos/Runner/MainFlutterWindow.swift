import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class MainFlutterWindow: NSWindow {
  var channel: FlutterMethodChannel!
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)

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
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
    self.styleMask.insert(.fullSizeContentView)

    // 画面どこを持っても移動できるようにする
    self.isMovable = true
    self.isMovableByWindowBackground = true

    channel = FlutterMethodChannel(name: "quick.flutter/panel", binaryMessenger: flutterViewController.engine.binaryMessenger)
    setHandler(channel: channel)

    super.awakeFromNib()
  }


  func setHandler(channel: FlutterMethodChannel) {
    // Flutter側でのイベントを受け取る
    channel.setMethodCallHandler { (call, result) in
      switch call.method {
      case "closeWindow":
        self.closeWindow()
        return
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

  func openPanel() {
    flutterEngine.run(withEntrypoint: "panel");
    let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)

    var newEntryPanel = FloatingPanel(contentRect: NSRect(x: 0, y: 0, width: 1200, height: 600), backing: .buffered, defer: false)

    newEntryPanel.title = "Floating Panel Title"
    newEntryPanel.contentView = flutterViewController.view
    newEntryPanel.contentViewController = flutterViewController
    RegisterGeneratedPlugins(registry: flutterViewController)

    newEntryPanel.orderFront(nil)
    newEntryPanel.makeKey()
  }

  /// ウィンドウをcloseする
  ///
  /// ウィンドウが表示されている場合は閉じ、表示されていない場合は開きます。
  func closeWindow() {
    self.close()
  }

  /// アプリケーションを終了する。
  func quit() {
    NSApplication.shared.terminate(nil)
  }
}

class FloatingPanel: NSPanel {
  init(contentRect: NSRect, backing: NSWindow.BackingStoreType, defer flag: Bool) {
    super.init(contentRect: contentRect, styleMask: [.nonactivatingPanel, .titled, .resizable, .closable, .fullSizeContentView], backing: backing, defer: flag)

    // Set this if you want the panel to remember its size/position
    //        self.setFrameAutosaveName("a unique name")

    // Allow the pannel to be on top of almost all other windows
    self.isFloatingPanel = true
    self.level = .floating

    // Allow the pannel to appear in a fullscreen space
    self.collectionBehavior.insert(.fullScreenAuxiliary)

    // While we may set a title for the window, don't show it
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true

    // Since there is no titlebar make the window moveable by click-dragging on the background
    self.isMovableByWindowBackground = true

    // Keep the panel around after closing since I expect the user to open/close it often
    self.isReleasedWhenClosed = false

    // Activate this if you want the window to hide once it is no longer focused
    //                self.hidesOnDeactivate = true

    // Hide the traffic icons (standard close, minimize, maximize buttons)
    self.standardWindowButton(.closeButton)?.isHidden = true
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true
  }

  // `canBecomeKey` and `canBecomeMain` are required so that text inputs inside the panel can receive focus
//    return true
//  }

  override var canBecomeMain: Bool {
    return true
  }

  override func resignMain() {
    super.resignMain()
    close()
  }

  override func close() {
    super.close()
  }

}
