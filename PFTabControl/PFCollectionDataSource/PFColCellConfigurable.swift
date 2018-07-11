//
//  PFColCellConfigurable.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/26.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

public protocol PFColCellConfigurable {
    var cellIdentifier : String{ get }
    var cellClass : AnyClass { get }
    var backgroundColor: UIColor { get }
    var selection: PFCellSelectable? { get }
    func config(_ cell: UICollectionViewCell)
}

private var risgterClass = [String]()

public struct ColInitRisgterClass{
    func initRisgter()  {
        risgterClass.removeAll()
    }
}

public struct PFColCellConfigurator<Cell: UICollectionViewCell>: PFColCellConfigurable where Cell: PFCellViewModel{
    
    public var cellIdentifier: String = NSStringFromClass(Cell.self)
    
    public let cellClass: AnyClass = Cell.self
    
    public var selection: PFCellSelectable?
    
    public var backgroundColor: UIColor
    private var complate : (_ result:Any) -> ()
    private weak var collectionView : UICollectionView?
    public func config(_ cell: UICollectionViewCell) {
        guard let `cell` = cell as? Cell else {
            fatalError("cell is not PFCellViewModel?! ")
        }
        cell.config(viewModel) { (result) in
            self.complate(result)
        }
    }
    
    public let viewModel: Cell.ViewModel
    
    public init(viewModel: Cell.ViewModel,
                backgroundColor: UIColor? = .clear,
                collectionView:UICollectionView?,
                selection: PFCellSelectable? = nil,
                complate :@escaping (_ result:Any) -> ()) {
        self.complate = complate
        self.viewModel = viewModel
        self.selection = selection
        self.collectionView = collectionView
        self.backgroundColor = backgroundColor!
        if !risgterClass.contains(cellIdentifier) {
            self.collectionView?.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
            risgterClass.insert(cellIdentifier, at: 0)
            print("ID:\(cellIdentifier)注册成功")
        }else{
            print("sorry，ID:\(cellIdentifier)在之前已经注册过了")
        }
    }
    
}












