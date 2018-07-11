//
//  PFTabHeardFootConfigurable.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/25.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

public protocol PFTabHeardFootConfigurable {
    var view : UIView? { get }
    var height : CGFloat { get }
    var lightHeight: CGFloat? { get }
    var backgroundColor: UIColor { get }
    func config(_ view: UIView)
}

public struct PFTabHeardFootConfigurator<View: UIView>: PFTabHeardFootConfigurable where View: PFCellViewModel{

    public var backgroundColor: UIColor
    
    public var view: UIView?
    
    public var height: CGFloat
    
    public var lightHeight: CGFloat?
    
    public let viewModel: View.ViewModel?
    
    public func config(_ view: UIView) {
        guard let `view` = view as? View else {
            fatalError("view is not PFCellViewModel?! ")
        }
        view.config(viewModel) { (result) in
            
        }
    }
    init(viewModel: View.ViewModel?,
         backgroundColor: UIColor? = .clear,
         view:UIView? = nil,
         height:CGFloat? = 0.0001,
         complate :@escaping (_ result:Any) -> ()) {
        
        self.height = height!
         self.backgroundColor = backgroundColor!
         self.view = view
         self.viewModel = viewModel
        
    }

}
