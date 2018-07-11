//
//  BaseCellModel.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/20.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

public protocol PFCellViewModel {

    associatedtype ViewModel
    
    var viewModel: ViewModel? { get }
    
    func config(_ viewModel: ViewModel?,complate :@escaping (_ result:Any) -> ())

}
