//
//  NetStore.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

struct NetStore {
    static let shared = NetStore()
    func goTabToDoItems(completionHandler: @escaping ([[Any]],[Any],[Any],Any,Any) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler(tabDataSource,tabHeardInSection,tabFootInSection,tabHeard,tabFoot)
        }
    }
    func getColToDoItems(completionHandler: @escaping ([[Any]],[[CGFloat]],[Any],[Any],Any,Any) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler(colDataSource,colHeights,colHeardInSection,colFootInSection,colHeard,colFoot)
        }
    }
    
    
}

let colHeights : [[CGFloat]] = [[80,150,200,60,30,90,300,100,100,50,220,160,300,90,200,180,45,95],
                  [320,150,80,200,70,90,100,30,220,180,50,65,30,160,90,170]]

let colDataSource = [
    [
        ColOneCellModel(one_Title: "大连", one_Image: "www.xxx.com/xxx/dalian.png"),
        ColOneCellModel(one_Title: "沈阳", one_Image: "www.xxx.com/xxx/shenyang.png"),
        ColOneCellModel(one_Title: "哈尔滨", one_Image: "www.xxx.com/xxx/haerbin.png"),
        ColOneCellModel(one_Title: "佳木斯", one_Image: "www.xxx.com/xxx/jiamusi.png"),
        ColOneCellModel(one_Title: "北京", one_Image: "www.xxx.com/xxx/beijing.png"),
        ColOneCellModel(one_Title: "武汉", one_Image: "www.xxx.com/xxx/wuhan.png"),
        ColOneCellModel(one_Title: "南京", one_Image: "www.xxx.com/xxx/nanjing.png"),
        ColOneCellModel(one_Title: "上海", one_Image: "www.xxx.com/xxx/shanghai.png"),
        ColOneCellModel(one_Title: "广州", one_Image: "www.xxx.com/xxx/guangzhou.png"),
        ColOneCellModel(one_Title: "西安", one_Image: "www.xxx.com/xxx/xian.png"),
        ColOneCellModel(one_Title: "天津", one_Image: "www.xxx.com/xxx/tianjin.png"),
        ColOneCellModel(one_Title: "青岛", one_Image: "www.xxx.com/xxx/qingdao.png"),
        ColOneCellModel(one_Title: "兰州", one_Image: "www.xxx.com/xxx/lanzhou.png"),
        ColOneCellModel(one_Title: "太原", one_Image: "www.xxx.com/xxx/taiyuan.png"),
        ColOneCellModel(one_Title: "赤峰", one_Image: "www.xxx.com/xxx/chifeng.png"),
        ColOneCellModel(one_Title: "甘肃", one_Image: "www.xxx.com/xxx/gansu.png"),
        ColOneCellModel(one_Title: "南昌", one_Image: "www.xxx.com/xxx/nanchang.png"),
        ColOneCellModel(one_Title: "贵阳", one_Image: "www.xxx.com/xxx/guiyang.png"),
    ],
    [
        ColOneCellModel(one_Title: "长沙", one_Image: "www.xxx.com/xxx/changsha.png"),
        ColOneCellModel(one_Title: "重庆", one_Image: "www.xxx.com/xxx/chongqing.png"),
        ColOneCellModel(one_Title: "拉萨", one_Image: "www.xxx.com/xxx/lasa.png"),
        ColOneCellModel(one_Title: "杭州", one_Image: "www.xxx.com/xxx/hangzhou.png"),
        ColOneCellModel(one_Title: "长春", one_Image: "www.xxx.com/xxx/changchun.png"),
        ColOneCellModel(one_Title: "银川", one_Image: "www.xxx.com/xxx/yinchuan.png"),
        ColOneCellModel(one_Title: "昆明", one_Image: "www.xxx.com/xxx/kunming.png"),
        ColOneCellModel(one_Title: "西宁", one_Image: "www.xxx.com/xxx/xining.png"),
        ColOneCellModel(one_Title: "香港", one_Image: "www.xxx.com/xxx/xianggang.png"),
        ColOneCellModel(one_Title: "澳门", one_Image: "www.xxx.com/xxx/aomen.png"),
        ColOneCellModel(one_Title: "台湾", one_Image: "www.xxx.com/xxx/taiwan.png"),
        ColOneCellModel(one_Title: "乌鲁木齐", one_Image: "www.xxx.com/xxx/wulumuqi.png"),
        ColOneCellModel(one_Title: "呼和浩特", one_Image: "www.xxx.com/xxx/huhehaote.png"),
        ColOneCellModel(one_Title: "济南", one_Image: "www.xxx.com/xxx/jinan.png"),
        ColOneCellModel(one_Title: "福州", one_Image: "www.xxx.com/xxx/fuzhou.png"),
        ColOneCellModel(one_Title: "合肥", one_Image: "www.xxx.com/xxx/hefei.png"),
        ]
]

let colHeardInSection = [ColHeardInSectionModel(heardSec_Name: "一些地方"),ColHeardInSectionModel(heardSec_Name: "另一些地方")]
let colFootInSection = [ColFootInSectionModel(footSec_Name: "编些什么好呢"),ColFootInSectionModel(footSec_Name: "实在不知道编些什么好了")]

let colHeard = ColHeardModel(heard_Text: "购买", heard_Details: "是个很费钱的事", heard_Image: "www.xxx.com/xxx/heardImage.png")
let colFoot = ColFootModel(foot_Text: "这是尾")

let tabDataSource = [
    [
        TabOneCellModel(one_Name: "张三", one_Title: "北京大学", one_Addr: "北京"),
        TabTwoCellModel(two_Title: "李四", two_Details: "是个男人"),
        TabThreeCellModel(three_Text: "春天", three_Details:"花儿开了"),
        TabThreeCellModel(three_Text: "夏天", three_Details:"叶儿绿了"),
        TabThreeCellModel(three_Text: "秋天", three_Details:"工作黄了"),
        TabOneCellModel(one_Name: "王五", one_Title: "大连大学", one_Addr: "大连"),
        TabTwoCellModel(two_Title: "春儿", two_Details: "是个女人"),
    ],
    [
        TabThreeCellModel(three_Text: "冬天", three_Details:"绿地脱光了"),
        TabThreeCellModel(three_Text: "白天", three_Details:"太阳热了"),
        TabTwoCellModel(two_Title: "丽丽", two_Details: "曾经是个女人"),
        TabThreeCellModel(three_Text: "夜天", three_Details:"月亮夜生活来了"),
        
    ]

]

let tabHeardInSection = [TabHeardInSectionModel(heardSec_Name: "这是什么鬼")]
let tabFootInSection = [TabFootInSectionModel(footSec_Name: "没有数据")]

let tabHeard = TabHeardModel(heard_Text: "衣服", heard_Details: "是用来穿的", heard_Image: "www.xxx.com/xxx/xxx.png")
let tabFoot = TabFootModel(foot_Text: "实在编不下去了")
