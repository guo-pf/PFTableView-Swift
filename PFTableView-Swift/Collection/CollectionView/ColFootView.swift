//
//  ColFootView.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ColFootView: UICollectionReusableView,PFCellViewModel {
     typealias ViewModel = ColFootModel
    var viewModel: ColFootModel?
    
    func config(_ viewModel: ColFootModel?, complate: @escaping (Any) -> ()) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
