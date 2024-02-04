import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class MainFlutterWindow: NSWindow {
  var newEntryPanel: FloatingPanel!
  var panelFlutterViewController: FlutterViewController!
  var channel: FlutterMethodChannel!
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    // NSApplicationの起動完了通知を購読
    NotificationCenter.default.addObserver(self, selector: #selector(appDidFinishLaunching), name: NSApplication.didFinishLaunchingNotification, object: nil)

    super.awakeFromNib()
  }

  @objc func appDidFinishLaunching(notification: Notification) {
    createFloatingPanel()
    NotificationCenter.default.removeObserver(self, name: NSApplication.didFinishLaunchingNotification, object: nil)
  }

  // NSPanelを開く
  func open() {
    newEntryPanel.orderFront(nil)
    newEntryPanel.makeKey()
  }

  // NSPanelを作成
  func createFloatingPanel() {
    // 変える場合はここ参照 https://stackoverflow.com/questions/77222222/flutterengine-runwithentrypoint-screenaentrypoint-still-looks-for-main-i
    flutterEngine.run(withEntrypoint: "panel")
    panelFlutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    panelFlutterViewController.backgroundColor = .clear

    channel = FlutterMethodChannel(name: "quick.flutter/panel", binaryMessenger: panelFlutterViewController.engine.binaryMessenger)

    newEntryPanel = FloatingPanel(contentRect: NSRect(x: 0, y: 0, width: 400, height: 600), backing: .buffered, defer: false, channel: channel)

    newEntryPanel.title = "Floating Panel Title"
    newEntryPanel.contentView = panelFlutterViewController.view
    newEntryPanel.contentViewController = panelFlutterViewController
    RegisterGeneratedPlugins(registry: panelFlutterViewController)

    setHandler()
  }

  func setHandler() {
    // Flutter側でのイベントを受け取る
    channel.setMethodCallHandler { (call, result) in
      let windowWidth = self.newEntryPanel.frame.width
      let windowHeight = self.newEntryPanel.frame.height
      let windowPositionY = self.newEntryPanel.frame.origin.y
      let windowPositionX = self.newEntryPanel.frame.origin.x

      // window移動のアニメーションのduration
      let windowAnimationDuration = 0.4
      let easeOutExpo = CAMediaTimingFunction(controlPoints: 0.19, 1.0, 0.22, 1.0)

      switch call.method {
      case "openOrClosePanel":
        // 開いてたら閉じて、閉じてたら開く
        if self.newEntryPanel.isVisible {
          self.newEntryPanel.close()
        } else {
          self.open()
        }
      case "setFrameSize":
        if let args = call.arguments as? [String: Any] {
          let width = (args["width"] as? Int) ?? Int(windowWidth)
          let height = (args["height"] as? Int) ?? Int(windowHeight)
          // NSPointは左下を基準とするため、Frameサイズ変更時に上を固定するためにwindowHeight - CGFloat(height)を足している
          let frame = NSRect(origin: NSPoint(x: windowPositionX, y: windowPositionY + (windowHeight - CGFloat(height))),
                             size: NSSize(width: width, height: height)
          )
          self.newEntryPanel.animator().setFrame(frame, display: true, animate: true)
        } else {
          print(FlutterError(code: "INVALID_ARGUMENT", message: "Width or height is not provided", details: nil))
        }
        return
      case "alwaysFloatingOn":
        self.newEntryPanel.alwaysFloating = true
        return
      case "alwaysFloatingOff":
        self.newEntryPanel.alwaysFloating = false
        // OFにした直後にwindow外部をタップしても閉じないので(resignMainが呼ばれない)
        // 仕方なく一度closeする。1度closeすれば次回以降期待した動作がする
        self.newEntryPanel.close()
        return
      case "windowToLeft":
        // 現在の高さのまま、左へ移動する
        let frame = NSRect(origin: NSPoint(x: 0, y: windowPositionY), size: NSSize(width: windowWidth, height: windowHeight))
        NSAnimationContext.runAnimationGroup({ context in
          context.duration = windowAnimationDuration
          context.timingFunction = easeOutExpo
          self.newEntryPanel.animator().setFrame(frame, display: true, animate: true)
        })

        return
      case "windowToRight":
        // 現在の高さのまま右へ移動
        if let screen = NSScreen.main?.visibleFrame {
          let newTopLeftPoint = NSPoint(x: screen.maxX - windowWidth, y: windowPositionY)
          let frame = NSRect(origin: newTopLeftPoint, size: NSSize(width: windowWidth, height: windowHeight))
          self.newEntryPanel.animator().setFrame(frame, display: true, animate: true)
          NSAnimationContext.runAnimationGroup({ context in
            context.duration = windowAnimationDuration
            context.timingFunction = easeOutExpo
            self.newEntryPanel.animator().setFrame(frame, display: true, animate: true)
          })
        }
        return
      default:
        result(FlutterMethodNotImplemented)
        return
      }
    }
  }
}

class FloatingPanel: NSPanel {
  var channel: FlutterMethodChannel
  /// 外部タップで閉じれるかどうか
  var alwaysFloating: Bool = true

  init(contentRect: NSRect, backing: NSWindow.BackingStoreType, defer flag: Bool, channel: FlutterMethodChannel) {
    self.channel = channel

    super.init(contentRect: contentRect,
               styleMask: [.nonactivatingPanel, .titled, .miniaturizable, .closable, .fullSizeContentView, .resizable],
               backing: backing,
               defer: flag)
    self.level = .floating
    self.isFloatingPanel = true
    self.hidesOnDeactivate = false

    // 左上のボタンを非表示にする
    self.standardWindowButton(.closeButton)?.isHidden = false
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true

    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true

    setupNotification()
  }

  // `canBecomeKey` and `canBecomeMain` are required so that text inputs inside the panel can receive focus
  override var canBecomeKey: Bool {
    return true
  }

  override var canBecomeMain: Bool {
    return true
  }

  override func resignMain() {
    if !alwaysFloating {
      close()
    }
    super.resignMain()
  }

  private func setupNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleDidBecomeKeyNotification(_:)), name: NSWindow.didBecomeKeyNotification, object: self)
    NotificationCenter.default.addObserver(self, selector: #selector(handleDidResignKeyNotification(_:)), name: NSWindow.didResignKeyNotification, object: self)
  }

  // ウィンドウがキーウィンドウになった時の処理を行う
  @objc private func handleDidBecomeKeyNotification(_ notification: Notification) {
    channel.invokeMethod("active", arguments: nil)
  }

  // ウィンドウが非アクティブになった時の処理
  @objc private func handleDidResignKeyNotification(_ notification: Notification) {
    channel.invokeMethod("inactive", arguments: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}
