//
//  Data.swift
//  Swift_Self_2
//
//  Created by MariyaShestakova on 8/18/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Foundation
import Cocoa

struct Data
{
    private var _id: Int
    private var _text: String
    private var _window: NSWindow?
    private var _maximized: Bool
    private var _minimized: Bool
    private var _closed: Bool
    
    
    public init(id: Int, text: String, window: NSWindow?, maximized: Bool, minimized: Bool, closed: Bool)
    {
        _id = id;
        _text = text;
        _window = window;
        _maximized = maximized;
        _minimized = minimized;
        _closed = closed;
    }
    
    public func getId() -> Int { return _id; }
    public func getText() -> String { return _text; }
    public func getWindow() -> NSWindow? { return _window; }
    public func isMaximized() -> Bool { return _maximized; }
    public func isMinimized() -> Bool { return _minimized; }
    public func isClosed() -> Bool { return _closed; }
    
    public mutating func setId(id: Int) { self._id = id; }
    public mutating func setText(text: String) { self._text = text; }
    public mutating func setWindow(window: NSWindow?) { self._window = window; }
    public mutating func setMaximized(maximized: Bool){ self._maximized = maximized; }
    public mutating func setMinimized(minimized: Bool) { self._minimized = minimized; }
    public mutating func setClosed(closed: Bool) { self._closed = closed; }
}

