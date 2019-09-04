//
//  ChildController.swift
//  Swift_Self_2
//
//  Created by MariyaShestakova on 8/18/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Foundation
import Cocoa

class Child : NSViewController, NSWindowDelegate
{
    private var _childId: Int!
    private var _childDelegate: ChildDelegate!
    
    @IBOutlet weak var _textField: NSTextField!
    
    public init(identifier id: Int, childDelegate delegate: ChildDelegate)
    {
        super.init(nibName: nil, bundle: nil)
        self._childId = id
        self._childDelegate = delegate
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    public func setData(identifier id: Int, childDelegate delegate: ChildDelegate)
    {
        self._childId = id
        self._childDelegate = delegate
    }
    
    func windowWillMiniaturize(_ notification: Notification) {
        _childDelegate.onWindowMinimized(id: _childId, minimized: true)
    }
    
    func windowDidDeminiaturize(_ notification: Notification) {
        _childDelegate.onWindowMinimized(id: _childId, minimized: false)
    }
    
    func windowWillEnterFullScreen(_ notification: Notification) {
        _childDelegate.onWindowMaximized(id: _childId, maximized: true)
    }
    
    func windowWillExitFullScreen(_ notification: Notification) {
        _childDelegate.onWindowMaximized(id: _childId, maximized: false)
    }
    
    func windowWillClose(_ notification: Notification) {
        _childDelegate.onChildWindowDisappear(id: _childId, closed: true)
    }
    
    @IBAction func okClicked(_ sender: Any)
    {
        self.view.window?.close()
        _childDelegate.onDataChanged(id: _childId, text: _textField.stringValue, closed: true)
    }
    
    @IBAction func cancelClicked(_ sender: Any)
    {
        self.view.window?.close()
        _childDelegate.onChildWindowDisappear(id: _childId, closed: true)
    }
}

