//
//  File.swift
//  Runner
//
//  Created by 今城洸幸 on 2024/07/07.
//
import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class FloatingPanel: NSPanel {
  var flutterViewController: FlutterViewController!
  var channelMethod: FlutterMethodChannel!

  init(flutterViewController: FlutterViewController) {
    super.init(contentRect: NSRect(x: 0, y: 0, width: 1200, height: 600),
               styleMask: [.nonactivatingPanel,
                           .titled,
                           .resizable,
                           .closable,
                           .fullSizeContentView
               ],
               backing: .buffered,
               defer: false
    )
    self.flutterViewController = flutterViewController

    // Set this if you want the panel to remember its size/position
    self.setFrameAutosaveName("a unique name")

    // Allow the pannel to be on top of almost all other windows
    self.isFloatingPanel = true
    self.level = .floating

    // Allow the pannel to appear in a fullscreen space
    self.collectionBehavior.insert(.fullScreenAuxiliary)

    // While we may set a title for the window, don't show it
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true

    // Keep the panel around after closing since I expect the user to open/close it often
    self.isReleasedWhenClosed = false

    // Activate this if you want the window to hide once it is no longer focused
    self.hidesOnDeactivate = true

    // Hide the traffic icons (standard close, minimize, maximize buttons)
    self.standardWindowButton(.closeButton)?.isHidden = true
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true

    channelMethod = FlutterMethodChannel(name: "quick.flutter/panel", binaryMessenger: flutterViewController.engine.binaryMessenger)
    setHandler()
  }

  override var canBecomeMain: Bool {
    return true
  }

  override var canBecomeKey: Bool {
      return true
  }

  override func resignMain() {
    super.resignMain()
    close()
  }

//  override func close() {
//    super.close()
//  }

  func setHandler() {
    // Flutter側でのイベントを受け取る
    channelMethod.setMethodCallHandler { (call, result) in
      switch call.method {
      case "resizePanel":
        self.setFrameSize(call: call)
        return
      default:
        result(FlutterMethodNotImplemented)
        return
      }
    }
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

  /// windowのサイズを変える
  ///
  /// ウィンドウが画面下にあれば上に大きくor小さくなり、
  /// 画面上にあれば下に大きくorちいさくなる。
  func setFrameSize(call: FlutterMethodCall) {
    if let args = call.arguments as? [String: Any] {
      let width = (args["width"] as? Int) ?? Int(self.frameWidth)
      let height = (args["height"] as? Int) ?? Int(self.frameHeight)

      // ウィンドウの位置によって上が伸びるか下が伸びるかのコードだが、
      // 使わないのでコメントアウトするが、いつか使うかもなのでコードを残しておく
      let screenHeight = NSScreen.main?.frame.height ?? 1080
      // ウィンドウの上部から画面上部までの距離
      let distanceToTop = screenHeight - (self.positionY + self.frameHeight)
      // ウィンドウの下部から画面下部までの距離
      let distanceToBottom = self.positionY
      if distanceToTop < distanceToBottom {
        // NSPointは左下を基準とするため、Frameサイズ変更時に上を固定するためにframeHeight - CGFloat(height)を足している
        let frame = NSRect(origin: NSPoint(x: self.positionX, y: self.positionY + (self.frameHeight - CGFloat(height))),
                           size: NSSize(width: width, height: height))
        self.animator().setFrame(frame, display: true, animate: true)
      } else {
        let frame = NSRect(origin: NSPoint(x: self.positionX, y: self.positionY),
                           size: NSSize(width: width, height: height)
        )
        self.animator().setFrame(frame, display: true, animate: true)
      }

    } else {
      print(FlutterError(code: "INVALID_ARGUMENT", message: "Width or height is not provided", details: nil))
    }
  }

}
