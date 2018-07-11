//
//  ColHeardModel.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ColHeardModel: NSObject {
    var heard_Text : String?
    var heard_Details  : String?
    var heard_Image  : String?
    //这个是为了造数据方便，使用过程中可根据实际操作
    init(heard_Text:String?,heard_Details :String?,heard_Image:String?) {
        self.heard_Text = heard_Text
        self.heard_Details = heard_Details
        self.heard_Image = heard_Image
    }
}
