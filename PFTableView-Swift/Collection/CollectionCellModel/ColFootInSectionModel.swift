//
//  ColFootInSectionModel.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ColFootInSectionModel: NSObject {
    var footSec_Name : String?
    //这个是为了造数据方便，使用过程中可根据实际操作
    init(footSec_Name:String?) {
        self.footSec_Name = footSec_Name
    }
}
