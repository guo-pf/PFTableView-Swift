//
//  ColOneCellModel.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class ColOneCellModel: NSObject {
    var one_Title : String?
    var one_Image  : String?
    //这个是为了造数据方便，使用过程中可根据实际操作
    init(one_Title:String?,one_Image :String?) {
        self.one_Title = one_Title
        self.one_Image = one_Image
    }
}
