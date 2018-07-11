//
//  TwoTableViewCell.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class TwoTableViewCell: UITableViewCell ,PFCellViewModel{
     typealias ViewModel = TabTwoCellModel
    var viewModel: TabTwoCellModel?
    
    func config(_ viewModel: TabTwoCellModel?, complate: @escaping (Any) -> ()) {
        
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
