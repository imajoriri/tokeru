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
  lazy var flutterEngine = FlutterEngine(name: "settings engine", project: nil)

  init() {
    super.init(contentRect: NSRect(x: 0, y: 0, width: 600, height: 600), styleMask: [.nonactivatingPanel, .titled, .resizable, .closable, .fullSizeContentView], backing: .buffered, defer: false)
    flutterEngine.run(withEntrypoint: "settings")
    let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.contentView = flutterViewController.view
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    self.level = .modalPanel
  }

  override var canBecomeKey: Bool {
    return false
  }

  override var canBecomeMain: Bool {
    return false
  }
}
