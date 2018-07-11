//
//  OneTableViewCell.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class OneTableViewCell: UITableViewCell ,PFCellViewModel{
    typealias ViewModel = TabOneCellModel
    var viewModel: TabOneCellModel?
    
    func config(_ viewModel: TabOneCellModel?, complate: @escaping (Any) -> ()) {
        
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
