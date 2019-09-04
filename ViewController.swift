//
//  ViewController.swift
//  Swift_Self_2
//
//  Created by MariyaShestakova on 8/14/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, ChildDelegate, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var _table: NSTableView!
    private var _tableData = [Data]()
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        _table.target = self
    }

    public override func viewWillAppear() {
        super.viewWillAppear()
        _table.reloadData()
    }
    
    @IBAction func showWindowClicked(_ sender: Any)
    {
        guard let wc = NSStoryboard.main?.instantiateController(withIdentifier: "WindowController") as? NSWindowController else { return }
        if let childWindow = wc.window
        {
            let childController = wc.contentViewController as! Child
            childController.setData(identifier: _tableData.count, childDelegate: self)
            
            _tableData.append(Data(id: _tableData.count, text: "", window: childWindow, maximized: false, minimized: false, closed: false))
            _table.reloadData()
            
            wc.showWindow(childWindow)
        }
    }
    
    @IBAction func closeAllWindowsClicked(_ sender: Any)
    {
        for item in (self._tableData)
        {
            item.getWindow()?.close()
        }
    }
    
    internal func onDataChanged(id: Int, text: String, closed: Bool)
    {
        _tableData[id].setText(text: text)
        _tableData[id].setClosed(closed: closed)
        _table.reloadData()
    }
    
    internal func onWindowMinimized(id: Int, minimized: Bool) -> Void
    {
        _tableData[id].setMinimized(minimized: minimized)
        _table.reloadData()
    }
    
    internal func onWindowMaximized(id: Int, maximized: Bool) -> Void
    {
        _tableData[id].setMaximized(maximized: maximized)
        _table.reloadData()
    }
    
    internal func onChildWindowDisappear(id: Int, closed: Bool)
    {
        _tableData[id].setClosed(closed: closed)
        _table.reloadData()
    }
    
    public func numberOfRows(in tableView: NSTableView) -> Int
    {
        return _tableData.count
    }
    
    fileprivate enum CellIdentifiers
    {
        static let idCell = "id"
        static let textCell = "text"
        static let maxCell = "maxState"
        static let minCell = "minState"
        static let closeCell = "closeState"
        static let maxButtonCell = "maxButton"
        static let minButtonCell = "minButton"
        static let closeButtonCell = "closeButton"
    }
    
    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        var content = ""
        var cellIdentifier = ""
        
        var item: Data
        if row <= _tableData.count
        {
            item = _tableData[row]
        }
        else
        {
            return nil
        }
        
        switch tableColumn
        {
        case tableView.tableColumns[0]:
            
            content = String(item.getId())
            cellIdentifier = CellIdentifiers.idCell
            
        case tableView.tableColumns[1]:
            
            content = item.getText()
            cellIdentifier = CellIdentifiers.textCell
            
        case tableView.tableColumns[2]:
            content = String(item.isMaximized())
            cellIdentifier = CellIdentifiers.maxCell
        case tableView.tableColumns[3]:
            content = String(item.isMinimized())
            cellIdentifier = CellIdentifiers.minCell
        case tableView.tableColumns[4]:
            content = String(item.isClosed())
            cellIdentifier = CellIdentifiers.closeCell
        case tableView.tableColumns[5]:
            content = "Max"
            cellIdentifier = CellIdentifiers.maxButtonCell
        case tableView.tableColumns[6]:
            content = "Min"
            cellIdentifier = CellIdentifiers.minButtonCell
        case tableView.tableColumns[7]:
            content = "Close"
            cellIdentifier = CellIdentifiers.closeButtonCell
        case .none:
            break
        case .some(_):
            break
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView
        {
            cell.textField?.stringValue = content
            return cell
        }
        
        return nil
    }
    
    @IBAction func maxButtonClicked(_ sender: Any)
    {
        _tableData[_table.row(for: sender as! NSView)].getWindow()?.toggleFullScreen(_tableData[_table.row(for: sender as! NSView)].getWindow())
    }
    
    @IBAction func minButtonClicked(_ sender: Any)
    {
        _tableData[_table.row(for: sender as! NSView)].getWindow()?.miniaturize(_tableData[_table.row(for: sender as! NSView)].getWindow())
    }

    @IBAction func closeButtonClicked(_ sender: Any)
    {
        _tableData[_table.row(for: sender as! NSView)].getWindow()?.close()
    }
}
