//
//  ColFootModel.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ColFootModel: NSObject {
    var foot_Text : String?
    //这个是为了造数据方便，使用过程中可根据实际操作
    init(foot_Text:String?) {
        self.foot_Text = foot_Text
    }
}
