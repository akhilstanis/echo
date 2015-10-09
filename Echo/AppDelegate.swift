//
//  AppDelegate.swift
//  Echo
//
//  Created by Akhil Stanislavose on 08/10/15.
//  Copyright (c) 2015 Akhil Stanislavose. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover    = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setupStatusItemButton()
        setupPopover()
        setupEventMonitor()
        registerNotifications()
    }

    func setupStatusItemButton() {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = Selector("togglePopover:")
        }
    }

    func setupPopover() {
        // Closing popover doesnt animate smoothly sometimes, so lets just disbale it.
        popover.animates = false
        popover.contentViewController = EchoViewController(nibName: "EchoViewController", bundle: nil)
    }

    func setupEventMonitor() {
        eventMonitor = EventMonitor(mask: .LeftMouseDownMask | .RightMouseDownMask) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
    }

    func registerNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "closePopover:", name:"closePopover", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleSettings:", name:"toggleSettings", object: nil)
    }

    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSMinYEdge)
            eventMonitor?.start()
        }
    }

    func toggleSettings(sender: AnyObject?) {
        let size = popover.contentSize
        let height = (size.height == 111.0 ? 153.0 : 111.0) as CGFloat
        let newSize = NSSize(width: size.width, height: height)
        popover.contentSize = newSize
    }

    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }

    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

}
