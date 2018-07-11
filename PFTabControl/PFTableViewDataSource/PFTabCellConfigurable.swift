//
//  PFTabCellConfigurable.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/20.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

public protocol PFTabCellConfigurable {
    var cellIdentifier : String{ get }
    var cellClass : AnyClass { get }
    var height : CGFloat { get }
    var lightHeight: CGFloat? { get }
    var backgroundColor: UIColor { get }
    var selection: PFCellSelectable? { get }
    var cellSet : PFTabCellSetting? { get }
    func config(_ cell: UITableViewCell)
}
private var risgterClass = [String]()

public struct TabInitRisgterClass{
    func initRisgter()  {
        risgterClass.removeAll()
    }
}

public struct PFTabCellConfigurator<Cell: UITableViewCell>: PFTabCellConfigurable,PFTabCellSetting where Cell: PFCellViewModel{
    
    public var cellIdentifier: String = NSStringFromClass(Cell.self)
    
    public let cellClass: AnyClass = Cell.self

    public var cellSet : PFTabCellSetting?
    
    public var selection: PFCellSelectable?
    
    public var height: CGFloat
    public var lightHeight: CGFloat?
    public var backgroundColor: UIColor
    private var complate : (_ result:Any) -> ()
    private weak var tableView : UITableView?
    public func config(_ cell: UITableViewCell) {
        guard let `cell` = cell as? Cell else {
            fatalError("cell is not PFCellViewModel?! ")
        }
        cell.config(viewModel) { (result) in
            self.complate(result)
        }
    }
    
    public let viewModel: Cell.ViewModel?
    
    public init(viewModel: Cell.ViewModel?,
                backgroundColor: UIColor? = .clear,
                height: CGFloat? = 44.0,
                lightHeight:CGFloat? = 0.0,
                tableView:UITableView?,
                cellSet:PFTabCellSetting? = nil,
                selection: PFCellSelectable? = nil,
                complate :@escaping (_ result:Any) -> ()) {
        self.complate = complate
        self.viewModel = viewModel
        self.height = height!
        self.selection = selection
        self.tableView = tableView
        self.backgroundColor = backgroundColor!
        if (cellSet != nil) {
            self.cellSet = cellSet
        }else{
            self.cellSet = (DefaultCellSet() as PFTabCellSetting)
        }
        lightHeight == 0.0 ? (self.lightHeight = height) : (self.lightHeight = lightHeight)
        if !risgterClass.contains(cellIdentifier) {
            self.tableView?.register(cellClass, forCellReuseIdentifier: cellIdentifier)
            risgterClass.insert(cellIdentifier, at: 0)
           print("ID:\(cellIdentifier)注册成功")
        }else{
           print("sorry，ID:\(cellIdentifier)在之前已经注册过了")
        }
    }
    
}


 class DefaultCellSet : PFTabCellSetting{
    var selectionStyle : UITableViewCellSelectionStyle{ return .none }
    var accessoryType:UITableViewCellAccessoryType { return .none }
}

public protocol PFTabCellSetting {
    var selectionStyle : UITableViewCellSelectionStyle { get }
    var accessoryType:UITableViewCellAccessoryType { get }
}

public extension PFTabCellSetting{
    var selectionStyle : UITableViewCellSelectionStyle{ return .none }
    var accessoryType:UITableViewCellAccessoryType { return .none }
}

