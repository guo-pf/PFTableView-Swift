//
//  MyTableDataSource.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class MyTableDataSource: PFTabDataSource {
    override  func cellConfig(_ tableView: UITableView,_ indexPath: IndexPath, _ model : Any) -> PFTabCellConfigurable?{
        
        if let oneModel = model as? TabOneCellModel {
            return  PFTabCellConfigurator<OneTableViewCell>(
                viewModel: oneModel,
                backgroundColor:.purple,
                height: 44,
                lightHeight:200,
                tableView: tableView,
                selection: PFCellSelectedAction(selectedAction: { (indexPath,model) in
                    print(model as Any)
                }), complate: { (result) in
                    
                    print("这里是cell返回的数据，例如当cell需要输入某些数据的时候：\(result)")
            }
            )
        }else if let twoModel  = model as? TabTwoCellModel{
            return  PFTabCellConfigurator<TwoTableViewCell>(
                viewModel: twoModel,
                backgroundColor:.red,
                height: 80,
                tableView: tableView,
                selection: PFCellSelectedAction(selectedAction: { (indexPath,model) in
                    print(model as Any)
                }), complate: { (result) in
                    
                    print("这里是cell返回的数据，例如当cell需要输入某些数据的时候：\(result)")
            }
            )
        }else if let threeModel = model as? TabThreeCellModel{
            return  PFTabCellConfigurator<ThreeTableViewCell>(
                viewModel: threeModel,
                backgroundColor:.brown,
                height: 18,
                lightHeight:200,
                tableView: tableView,
                selection: PFCellSelectedAction(selectedAction: { (indexPath,model) in
                    print(model as Any)
                }), complate: { (result) in
                    
                    print("这里是cell返回的数据，例如当cell需要输入某些数据的时候：\(result)")
            }
            )
        }
        return nil
    }
    
    
    // 表头
    override func heardView(_ tableView: UITableView,_ model : Any?) -> PFTabHeardFootConfigurable? {
        let view =  TabHeardView()
        view.backgroundColor = UIColor.orange
        return PFTabHeardFootConfigurator<TabHeardView>(viewModel:model != nil ? (model as! TabHeardModel):nil,
                                                       view:view,
                                                       height:300,
                                                       complate: { (result) in
                                                        print("这里是view返回的数据，例如点击该view里面某个按钮：\(result)")
        })
    }
    //表尾
    override func footView(_ tableView: UITableView,_ model : Any?) -> PFTabHeardFootConfigurable? {
        let view =  TabFootView()
        view.backgroundColor = UIColor.yellow
        return PFTabHeardFootConfigurator<TabFootView>(viewModel:model != nil ? (model as! TabFootModel):nil,
                                                      view:view,
                                                      height:300,
                                                      complate: { (result) in
                                                        print("这里是view返回的数据，例如点击该view里面某个按钮：\(result)")
                                                        
        })
    }
    //组头
    override func heardInSectionConfig(_ tableView: UITableView,_ section: Int, _ model: [Any], _ maxCount : Int ) -> PFTabHeardFootConfigurable?{
        
        if section == 0 {
            let heardModel = model[0] as! TabHeardInSectionModel
            let view =  TabHeardInSecView()
            view.backgroundColor = UIColor.black
            return PFTabHeardFootConfigurator<TabHeardInSecView>(viewModel:heardModel,
                                                                    view: view,
                                                                    height: 50,
                                                                    complate: { (result) in
                                                                        print("这里是view返回的数据，例如点击该view里面某个按钮：\(result)")
            })
        }
        return nil
    }
    //组尾
    override func footerInSectionConfig(_ tableView: UITableView,_ section: Int, _ model: [Any], _ maxCount : Int ) -> PFTabHeardFootConfigurable?{
        if section == maxCount - 1 {
            let footModel = model[0] as! TabFootInSectionModel
            let view =  TabFootInSecView()
            view.backgroundColor = UIColor.gray
            return PFTabHeardFootConfigurator<TabFootInSecView>(viewModel:footModel,
                                                                   view: view,
                                                                   height: 10, complate: { (result) in
                                                                    print("这里是view返回的数据，例如点击该view里面某个按钮：\(result)")
            })
        }
        return nil
        
    }
    
    
    
    
}
