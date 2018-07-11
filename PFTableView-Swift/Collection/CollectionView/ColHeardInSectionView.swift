//
//  ColHeardInSectionView.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ColHeardInSectionView: UICollectionReusableView ,PFCellViewModel{
     typealias ViewModel = ColHeardInSectionModel
    var viewModel: ColHeardInSectionModel?
    
    func config(_ viewModel: ColHeardInSectionModel?, complate: @escaping (Any) -> ()) {
        
    }
    
   
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
