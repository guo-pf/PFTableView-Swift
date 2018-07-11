//
//  ExtensionBaseTableDelegate.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/26.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

extension PFTabDataSource :UITableViewDelegate{
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if (cellSelects.count) > indexPath.section  && (cellSelects[indexPath.section].count) > indexPath.row {
            if (lightHeights.count) > indexPath.section  && (lightHeights[indexPath.section].count) > indexPath.row {
                let hei = rowHeights[indexPath.section][indexPath.row] as CGFloat
                let lhei = lightHeights[indexPath.section][indexPath.row] as CGFloat
                rowHeights[indexPath.section].replaceSubrange(indexPath.row..<indexPath.row+1, with: repeatElement(lhei, count: 1))
                lightHeights[indexPath.section].replaceSubrange(indexPath.row..<indexPath.row+1, with: repeatElement(hei, count: 1))
                self.owner?.reloadRows(at: [indexPath], with: .automatic)
            }
            cellSelects[indexPath.section][indexPath.row].disSelected(indexPath,todos![indexPath.section][indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        guard self.todos != nil else {
            return 0
        }
        if (rowHeights.count) > indexPath.section {
            if (rowHeights[indexPath.section].count) > indexPath.row{
                return rowHeights[indexPath.section][indexPath.row]
            }else{
                return 0
            }
            
        }else{
            return 0
        }
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if  self.heardInSectionData != nil {
            var headerView = UIView()
            if heards.keys.contains(section) {
                let configure = heards[section]
                headerView.backgroundColor =  configure??.backgroundColor
                if let view = configure??.view {
                    headerView = view
                    configure??.config(headerView)
                }
                return headerView
            }else{
                return nil
            }
            
        }
        return nil
    }
    
    internal func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.footInSectionData != nil{
            var headerView = UIView()
            if foots.keys.contains(section) {
                let configure = foots[section]
                headerView.backgroundColor =  configure??.backgroundColor
                if let view = configure??.view {
                    headerView = view
                    configure??.config(headerView)
                }
                
                return headerView
            }else{
                return nil
            }
            
        }
        return nil
        
    }
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.heardInSectionData != nil{
            let configure = heardInSectionConfig(tableView, section, self.heardInSectionData!, (self.todos?.count)!)
            if configure != nil {
                heards.updateValue(configure, forKey: section)
                return (configure?.height)!
            }
            return 0.0001
        }
        
        return 0.0001
    }
    internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.footInSectionData != nil{
            let configure = footerInSectionConfig(tableView, section, self.footInSectionData!, (self.todos?.count)!)
            if configure != nil {
                foots.updateValue(configure, forKey: section)
                return (configure?.height)!
            }
            return 0.0001
        }
        
        return 0.0001
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
//        //设置动画时间为0.25秒，xy方向缩放的最终值为1
//        UIView.animate(withDuration: 0.25, animations: {
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
//        })
    }
    
    internal func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
    }
    
    internal func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int){
        
    }
    
    internal func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath){

    }
    
    internal func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int){
        
    }
    
    internal func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int){
        
    }
    
//    internal  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
//
//    }
//    internal func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat{
//
//    }
//    internal func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat{
//
//    }
    internal func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        
    }
//    internal func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
//
//    }
//    internal func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?{
//
//    }
    internal func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        
    }
//    internal func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
//
//    }
//    internal func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
//
//    }
//    internal func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
//
//    }
//    internal func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
//
//    }
//    internal func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
//
//    }
//    internal func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool{
//
//    }
    internal func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath){
        
    }
    internal func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?){
        
    }
//    internal func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath{
//
//    }
//    internal func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int{
//
//    }
//    internal func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool{
//
//    }
//    internal func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?){
//
//    }
//    internal func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool{
//
//    }
    internal func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator){
        
    }
//    internal func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?{
//        
//    }
//    internal func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool{
//        
//    }
    
    
    
    
    
}
