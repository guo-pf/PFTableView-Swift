//
//  TabOneCellModel.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class TabOneCellModel: NSObject {
    var one_Name  : String?
    var one_Title : String?
    var one_Addr  : String?
    //这个是为了造数据方便，使用过程中可根据实际操作
    init(one_Name: String?, one_Title:String?,one_Addr :String?) {
        self.one_Name = one_Name
        self.one_Title = one_Title
        self.one_Addr = one_Addr
    }
}
