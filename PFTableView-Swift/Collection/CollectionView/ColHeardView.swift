//
//  ColHeardView.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ColHeardView: UICollectionReusableView,PFCellViewModel {
    typealias ViewModel = ColHeardModel
    var viewModel: ColHeardModel?
    
    func config(_ viewModel: ColHeardModel?, complate: @escaping (Any) -> ()) {
        
    }
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
