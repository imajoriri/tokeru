import Cocoa
import FlutterMacOS
import HotKey
import SwiftUI
import Firebase

class MainFlutterWindow: NSWindow {
  let hotKey = HotKey(key: .r, modifiers: [.command, .option])
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
      self.open()
    }
    
    createFloatingPanel()
    
    // Center doesn't place it in the absolute center, see the documentation for more details
    newEntryPanel.center()
    NotificationCenter.default.removeObserver(self, name: NSApplication.didFinishLaunchingNotification, object: nil)
  }
  
  func open() {
    // Shows the panel and makes it active
    newEntryPanel.orderFront(nil)
    newEntryPanel.makeKey()
    
    channel.invokeMethod("openPanel", arguments: nil)
  }
  
  func createFloatingPanel() {
    // 変える場合はここ参照 https://stackoverflow.com/questions/77222222/flutterengine-runwithentrypoint-screenaentrypoint-still-looks-for-main-i
    flutterEngine.run(withEntrypoint: "panel");
    panelFlutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    channel = FlutterMethodChannel(
      name: "net.cbtdev.sample/method",
      binaryMessenger: panelFlutterViewController.engine.binaryMessenger)
    
    newEntryPanel = FloatingPanel(contentRect: NSRect(x: 0, y: 0, width: 1200, height: 600), backing: .buffered, defer: false)
    
    newEntryPanel.title = "Floating Panel Title"
    newEntryPanel.contentView = panelFlutterViewController.view
    newEntryPanel.contentViewController = panelFlutterViewController
    RegisterGeneratedPlugins(registry: panelFlutterViewController)
  }
}

class FloatingPanel: NSPanel {
  init(contentRect: NSRect, backing: NSWindow.BackingStoreType, defer flag: Bool) {
    
    // Not sure if .titled does affect anything here. Kept it because I think it might help with accessibility but I did not test that.
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
  override var canBecomeKey: Bool {
    return true
  }
  
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


struct ContentView: View {
  
  var body: some View {
    VStack {
      Text("default view")
    }
    .padding()
    
  }
}
