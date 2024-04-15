//
//  SwiftUIView.swift
//  Runner
//
//  Created by 今城洸幸 on 2024/04/15.
//

import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class SettingsView: NSPanel {
  var channel: FlutterMethodChannel!
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

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
//    self.isMovable = true
//    self.isMovableByWindowBackground = true

    // 画面がバックグラウンドになった後、5分後に勝手に落ちるのを防ぐ
//    self.isReleasedWhenClosed = false

//    setupNotification()

    channel = FlutterMethodChannel(name: "quick.flutter/panel", binaryMessenger: flutterViewController.engine.binaryMessenger)
//    setHandler(channel: channel)
    super.awakeFromNib()
  }

  override var canBecomeKey: Bool {
      return false
    }

    override var canBecomeMain: Bool {
      return false
    }
}

//struct SettingsView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

//#Preview {
//    SwiftUIView()
//}
