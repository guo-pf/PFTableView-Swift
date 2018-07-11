//
//  PFCellSelectedAction.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/7/2.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit
public protocol PFCellSelectable {
    func disSelected(_ indexPath: IndexPath,_ model:Any?)
}
public struct PFCellSelectedAction: PFCellSelectable {
    private var selectedAction: ((IndexPath,Any?) -> Void)
    
    public init(selectedAction: @escaping ((IndexPath,Any?) -> Void)) {
        self.selectedAction = selectedAction
    }
    
    public func disSelected(_ indexPath: IndexPath,_ model:Any?) {
        selectedAction(indexPath,model)
        
    }
}
