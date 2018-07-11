//
//  TabTwoCellModel.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class TabTwoCellModel: NSObject {
    var two_Title : String?
    var two_Details  : String?
    //这个是为了造数据方便，使用过程中可根据实际操作
    init(two_Title:String?,two_Details :String?) {
        self.two_Title = two_Title
        self.two_Details = two_Details
    }
}
