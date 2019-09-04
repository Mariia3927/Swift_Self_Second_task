//
//  ChildDelegate.swift
//  Swift_Self_2
//
//  Created by MariyaShestakova on 8/18/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Foundation
import Cocoa

protocol ChildDelegate
{
    func onDataChanged(id: Int, text: String, closed: Bool) -> Void
    
    func onWindowMinimized(id: Int, minimized: Bool) -> Void
    func onWindowMaximized(id: Int, maximized: Bool) -> Void
    
    func onChildWindowDisappear(id: Int, closed: Bool) -> Void
}
