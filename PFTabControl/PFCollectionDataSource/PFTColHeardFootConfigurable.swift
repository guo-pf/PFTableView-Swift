//
//  PFTColHeardFootConfigurable.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/7/1.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

public protocol PFColHeardFootConfigurable {
    var viewIdentifier : String{ get }
    var viewClass : AnyClass { get }
    var view : UICollectionReusableView? { get }
    var backgroundColor: UIColor { get }
    var height:CGFloat? { get }
    func config(_ view: UIView)
}

public struct PFColHeardFootConfigurator<View: UICollectionReusableView>: PFColHeardFootConfigurable where View: PFCellViewModel{
    
    public var height: CGFloat?
    
    public var viewIdentifier: String = NSStringFromClass(View.self)
    
    public let viewClass: AnyClass = View.self
    
    
    public var backgroundColor: UIColor
    
    public var view: UICollectionReusableView?
    
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
         height:CGFloat? = 0.0,
         complate :@escaping (_ result:Any) -> ()) {
        if view != nil {
            viewIdentifier = String.init(utf8String: object_getClassName(view))!
        }
        self.height = height
        self.backgroundColor = backgroundColor!
        self.view = (view as! UICollectionReusableView)
        self.view?.backgroundColor = backgroundColor!
        self.viewModel = viewModel
        
    }
    
}
