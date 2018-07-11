//
//  ExtensionTableData.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/26.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit
extension PFTabDataSource : UITableViewDataSource{

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.todos != nil else {
            return 0
        }
        return self.todos![section].count
    }
    internal func numberOfSections(in tableView: UITableView) -> Int {
        guard self.todos != nil else {
        return 0
        }
        return (self.todos?.count)!
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        
        let configure : PFTabCellConfigurable?
        if cellConfigs.keys.contains(indexPath) {
            configure = cellConfigs[indexPath]
        }else{
            configure = cellConfig(tableView, indexPath , self.todos![indexPath.section][indexPath.row])
            if configure != nil{
                cellConfigs.updateValue(configure!, forKey: indexPath)
            }
        }
        guard configure != nil  else {
            let cell = tableView.dequeueReusableCell(withIdentifier:defaultCellIdentifier!, for: indexPath) as UITableViewCell
            cell.textLabel?.text = "数据不匹配。。。"
            editCellConfigure(44, indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: (configure?.cellIdentifier)!, for: indexPath)
        configure?.config(cell)
        cell.backgroundColor = configure?.backgroundColor
        cell.selectionStyle = (configure?.cellSet?.selectionStyle)!
        cell.accessoryType = (configure?.cellSet?.accessoryType)!
        editCellConfigure(configure!, indexPath)
        return cell
    }
    
//    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
//    internal func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?{
//
//    }
//    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//
//    }
//    internal func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//
//    }
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
    }
    internal func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        
    }

}


