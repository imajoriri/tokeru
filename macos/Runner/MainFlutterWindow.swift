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
    let windowSize = NSSize(width: 600, height: 500)

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

//    self.level = .floating

    // 左上のボタンを操作
//    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
//    self.standardWindowButton(.zoomButton)?.isHidden = true
//    self.standardWindowButton(.closeButton)?.isHidden = true

    // タイトルを非表示にする
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
    self.styleMask.insert(.fullSizeContentView)
    // nonactivatingPanelによってTokeruを開いても下のウィンドウのフォーカスが失われない
    self.styleMask.insert(.nonactivatingPanel)

//    self.collectionBehavior = [
//      // スクリーンのスペースを移動しても表示し続ける
//      .canJoinAllSpaces
//    ]

    // 画面どこを持っても移動できるようにする
    self.isMovable = true
    self.isMovableByWindowBackground = true

    // 画面がバックグラウンドになった後、5分後に勝手に落ちるのを防ぐ
//    self.isReleasedWhenClosed = false

    setupNotification()

    channel = FlutterMethodChannel(name: "quick.flutter/panel", binaryMessenger: flutterViewController.engine.binaryMessenger)
    setHandler(channel: channel)

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
    channel.invokeMethod("active", arguments: nil)
  }

  // ウィンドウが非アクティブになった時の処理
  @objc private func handleDidResignKeyNotification(_ notification: Notification) {
    channel.invokeMethod("inactive", arguments: nil)
  }

//  override func resignMain() {
//    // ここでclose()を呼ばないことで、外部をタップしても閉じない
//    super.resignMain()
//  }
//
  override func close() {
    NSApplication.shared.terminate(nil)
//    super.close()
    // hideによって、Tokeruを閉じた時に下のウィンドウに再フォーカスされる
//    NSApp.hide(self)
  }

  var frameWidth: CGFloat {
    return self.frame.width
  }

  var frameHeight: CGFloat {
    return self.frame.height
  }

  /// ウィンドウ左下を基準とした縦のポジション
  var positionY: CGFloat {
    return self.frame.origin.y
  }

  /// ウィンドウ左下を基準とした横のポジション
  var positionX: CGFloat {
    return self.frame.origin.x
  }

  /// window移動のアニメーションのduration
  var windowAnimationDuration: Double {
    return 0.4
  }

  /// window移動のアニメーション定義
  var windowAnimation: CAMediaTimingFunction {
    // easeOutExpo
    return CAMediaTimingFunction(controlPoints: 0.19, 1.0, 0.22, 1.0);
  }

  func setHandler(channel: FlutterMethodChannel) {
    // Flutter側でのイベントを受け取る
    channel.setMethodCallHandler { (call, result) in
      switch call.method {
      case "openOrClosePanel":
        self.openOrCloseWindow()
        return
      case "closeWindow":
        self.closeWindow()
        return
      case "setFrameSize":
        self.setFrameSize(call: call)
        return
      case "switchHorizen":
        self.switchHorizen()
        return
      case "windowToLeft":
        self.windowToLeft()
        return
      case "windowToRight":
        self.windowToRight()
        return
      case "quit":
        self.quit()
      default:
        result(FlutterMethodNotImplemented)
        return
      }
    }
  }

  /// ウィンドウが右にあれば左端に、左にあれば右端に移動する
  func switchHorizen() {
    if let screen = NSScreen.main?.visibleFrame {
      // ウィンドウが今、画面の右にるかどうか
      let isRight = self.positionX > screen.midX
      if isRight {
        self.windowToLeft()
      } else {
        self.windowToRight()
      }
    }
  }

  /// ウィンドウの表示状態を切り替えます。
  ///
  /// ウィンドウが表示されている場合は閉じ、表示されていない場合は開きます。
  func openOrCloseWindow() {
    if self.isVisible {
      self.close()
    } else {
      self.makeKeyAndOrderFront(nil)
      NSApp.activate(ignoringOtherApps: true)
    }
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

  /// windowのサイズを変える
  ///
  /// ウィンドウが画面下にあれば上に大きくor小さくなり、
  /// 画面上にあれば下に大きくorちいさくなる。
  func setFrameSize(call: FlutterMethodCall) {
    if let args = call.arguments as? [String: Any] {
      let width = (args["width"] as? Int) ?? Int(self.frameWidth)
      let height = (args["height"] as? Int) ?? Int(self.frameHeight)
      let frame = NSRect(origin: NSPoint(x: self.positionX, y: self.positionY + (self.frameHeight - CGFloat(height))),
                         size: NSSize(width: width, height: height))
      self.animator().setFrame(frame, display: true, animate: true)

      // ウィンドウの位置によって上が伸びるか下が伸びるかのコードだが、
      // 使わないのでコメントアウトするが、いつか使うかもなのでコードを残しておく
//      let screenHeight = NSScreen.main?.frame.height ?? 1080
//      // ウィンドウの上部から画面上部までの距離
//      let distanceToTop = screenHeight - (self.positionY + self.frameHeight)
//      // ウィンドウの下部から画面下部までの距離
//      let distanceToBottom = self.positionY
//      if distanceToTop < distanceToBottom {
//        // NSPointは左下を基準とするため、Frameサイズ変更時に上を固定するためにframeHeight - CGFloat(height)を足している
//        let frame = NSRect(origin: NSPoint(x: self.positionX, y: self.positionY + (self.frameHeight - CGFloat(height))),
//                           size: NSSize(width: width, height: height))
//        self.animator().setFrame(frame, display: true, animate: true)
//      } else {
//        let frame = NSRect(origin: NSPoint(x: self.positionX, y: self.positionY),
//                           size: NSSize(width: width, height: height)
//        )
//        self.animator().setFrame(frame, display: true, animate: true)
//      }

    } else {
      print(FlutterError(code: "INVALID_ARGUMENT", message: "Width or height is not provided", details: nil))
    }
  }

  func windowToLeft() {
    // 現在の高さのまま、左へ移動する
    let frame = NSRect(origin: NSPoint(x: 0, y: self.positionY), size: NSSize(width: self.frameWidth, height: self.frameHeight))
    NSAnimationContext.runAnimationGroup({ context in
      context.duration = self.windowAnimationDuration
      context.timingFunction = self.windowAnimation
      self.animator().setFrame(frame, display: true, animate: true)
    })
  }

  func windowToRight() {
    // 現在の高さのまま右へ移動
    if let screen = NSScreen.main?.visibleFrame {
      let newTopLeftPoint = NSPoint(x: screen.maxX - self.frameWidth, y: self.positionY)
      let frame = NSRect(origin: newTopLeftPoint, size: NSSize(width: self.frameWidth, height: self.frameHeight))
      self.animator().setFrame(frame, display: true, animate: true)
      NSAnimationContext.runAnimationGroup({ context in
        context.duration = self.windowAnimationDuration
        context.timingFunction = self.windowAnimation
        self.animator().setFrame(frame, display: true, animate: true)
      })
    }
  }
}
