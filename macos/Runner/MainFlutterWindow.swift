import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class MainFlutterWindow: NSWindow {
  let hotKey = HotKey(key: .comma, modifiers: [.command, .shift])
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
    hotKey.keyDownHandler = {
      // 開いてたら閉じて、閉じてたら開く
      if(self.newEntryPanel.isVisible) {
        self.newEntryPanel.close()
      } else {
        self.open()
      }
    }
    
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
    flutterEngine.run(withEntrypoint: "panel");
    panelFlutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    panelFlutterViewController.backgroundColor = .clear

    newEntryPanel = FloatingPanel(contentRect: NSRect(x: 0, y: 0, width: 400, height: 600), backing: .buffered, defer: false)
    
    newEntryPanel.title = "Floating Panel Title"
    newEntryPanel.contentView = panelFlutterViewController.view
    newEntryPanel.contentViewController = panelFlutterViewController
    RegisterGeneratedPlugins(registry: panelFlutterViewController)

    // Flutter側でのイベントを受け取る
    channel = FlutterMethodChannel(name: "quick.flutter/panel", binaryMessenger: panelFlutterViewController.engine.binaryMessenger);
    channel.setMethodCallHandler { (call, result) in
      let windowWidth = self.newEntryPanel.frame.width
      let windowHeight = self.newEntryPanel.frame.height
      let windowPositionY = self.newEntryPanel.frame.origin.y

      // window移動のアニメーションのduration
      let windowAnimationDuration = 0.4
      let easeOutExpo = CAMediaTimingFunction(controlPoints: 0.19, 1.0, 0.22, 1.0)

      switch call.method {
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
        // 現在ん高さのまま右へ移動
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
  /// 外部タップで閉じれるかどうか
  var alwaysFloating: Bool = true

  init(contentRect: NSRect, backing: NSWindow.BackingStoreType, defer flag: Bool) {
    
    super.init(contentRect: contentRect, styleMask: [.nonactivatingPanel, .titled, .miniaturizable, .closable, .fullSizeContentView, .resizable], backing: backing, defer: flag)
    self.level = .floating
    self.isFloatingPanel = true
    self.hidesOnDeactivate = false

    // 左上のボタンを非表示にする
    self.standardWindowButton(.closeButton)?.isHidden = false
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true

    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
  }
  
  // `canBecomeKey` and `canBecomeMain` are required so that text inputs inside the panel can receive focus
  override var canBecomeKey: Bool {
    return true
  }

  override var canBecomeMain: Bool {
    return true
  }
  
  override func resignMain() {
    if(!alwaysFloating) {
      close()
    }
    super.resignMain()
  }

  override func close() {
    super.close()
  }
}
