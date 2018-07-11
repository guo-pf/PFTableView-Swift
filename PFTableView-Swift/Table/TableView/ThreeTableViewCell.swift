//
//  ThreeTableViewCell.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ThreeTableViewCell: UITableViewCell ,PFCellViewModel{
    typealias ViewModel = TabThreeCellModel
    var viewModel: TabThreeCellModel?
    
    func config(_ viewModel: TabThreeCellModel?, complate: @escaping (Any) -> ()) {
        
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
