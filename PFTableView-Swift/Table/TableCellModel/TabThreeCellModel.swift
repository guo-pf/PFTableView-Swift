//
//  TabThreeCellModel.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class TabThreeCellModel: NSObject {
    var three_Text : String?
    var three_Details  : String?
    //这个是为了造数据方便，使用过程中可根据实际操作
    init(three_Text:String?,three_Details :String?) {
        self.three_Text = three_Text
        self.three_Details = three_Details
    }
}
