import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class MainFlutterWindow: NSWindow {
  var channel: FlutterMethodChannel!
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    // デフォルトのウィンドウサイズを設定
    self.setFrame(NSRect(x: 0, y: 0, width: 400, height: 700), display: true)

    self.level = .floating

    // 非アクティブになってもウィンドウが削除されない
    self.hidesOnDeactivate = false

    // 左上のボタンを非表示にする
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true
    // 削除ボタンは表示する
    self.standardWindowButton(.closeButton)?.isHidden = false

    // タイトルを非表示にする
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
    self.styleMask.insert(.fullSizeContentView)

    self.collectionBehavior = [
      // スクリーンのスペースを移動しても表示し続ける
      .canJoinAllSpaces
    ]

    // 画面どこを持っても移動できるようにする
    self.isMovable = true
    self.isMovableByWindowBackground = true

    setupNotification()

    channel = FlutterMethodChannel(name: "quick.flutter/panel", binaryMessenger: flutterViewController.engine.binaryMessenger)
    setHandler(channel: channel)
    super.awakeFromNib()
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

  override func resignMain() {
    // ここでclose()を呼ばないことで、外部をタップしても閉じない
    super.resignMain()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func setHandler(channel: FlutterMethodChannel) {
    // Flutter側でのイベントを受け取る
    channel.setMethodCallHandler { (call, result) in
      let windowWidth = self.frame.width
      let windowHeight = self.frame.height
      let windowPositionY = self.frame.origin.y
      let windowPositionX = self.frame.origin.x

      // window移動のアニメーションのduration
      let windowAnimationDuration = 0.4
      let easeOutExpo = CAMediaTimingFunction(controlPoints: 0.19, 1.0, 0.22, 1.0)

      switch call.method {
      case "openOrClosePanel":
        // 開いてたら閉じて、閉じてたら開く
        if self.isVisible {
          self.close()
        } else {
          self.makeKeyAndOrderFront(nil)
        }
      case "setFrameSize":
        if let args = call.arguments as? [String: Any] {
          let width = (args["width"] as? Int) ?? Int(windowWidth)
          let height = (args["height"] as? Int) ?? Int(windowHeight)
          // NSPointは左下を基準とするため、Frameサイズ変更時に上を固定するためにwindowHeight - CGFloat(height)を足している
          let frame = NSRect(origin: NSPoint(x: windowPositionX, y: windowPositionY + (windowHeight - CGFloat(height))),
                             size: NSSize(width: width, height: height)
          )
          self.animator().setFrame(frame, display: true, animate: true)
        } else {
          print(FlutterError(code: "INVALID_ARGUMENT", message: "Width or height is not provided", details: nil))
        }
        return
      case "windowToLeft":
        // 現在の高さのまま、左へ移動する
        let frame = NSRect(origin: NSPoint(x: 0, y: windowPositionY), size: NSSize(width: windowWidth, height: windowHeight))
        NSAnimationContext.runAnimationGroup({ context in
          context.duration = windowAnimationDuration
          context.timingFunction = easeOutExpo
          self.animator().setFrame(frame, display: true, animate: true)
        })

        return
      case "windowToRight":
        // 現在の高さのまま右へ移動
        if let screen = NSScreen.main?.visibleFrame {
          let newTopLeftPoint = NSPoint(x: screen.maxX - windowWidth, y: windowPositionY)
          let frame = NSRect(origin: newTopLeftPoint, size: NSSize(width: windowWidth, height: windowHeight))
          self.animator().setFrame(frame, display: true, animate: true)
          NSAnimationContext.runAnimationGroup({ context in
            context.duration = windowAnimationDuration
            context.timingFunction = easeOutExpo
            self.animator().setFrame(frame, display: true, animate: true)
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
