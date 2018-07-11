//
//  PFExtensionColDelegate.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/27.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

extension PFColDataSource: UICollectionViewDelegate{

    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard self.layout != nil else{
            return
        }
        switch self.layout?.flowLayouttyle {
        case .horPopup(_,_,_)?:
            var count : NSInteger =  0
            if scrollView.contentOffset.x < (self.layout?.itemSize.width)!/2.0 {
                count = 0
            }else if (self.layout?.collectionViewContentSize.width)! - scrollView.contentOffset.x -  UIScreen.main.bounds.size.width < (layout?.itemSize.width)!/2.0 {
                count = (self.todos?.first?.count)! - 1
                
            }else{
                count =  lroundf(Float((scrollView.contentOffset.x + (self.layout?.minimumLineSpacing)!)/CGFloat((self.layout?.itemSize.width)! + (layout?.minimumLineSpacing)!)))
                if count < 0{
                    count = 0
                }
                if count > (self.todos?.first?.count)!{
                    count = (self.todos?.first?.count)! - 1
                }
            }
            let indexPath = NSIndexPath(row: count, section: 0)
            self.owner?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            
            break
        default: break
            
        }
       
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if (cellSelects.count) > indexPath.section  && (cellSelects[indexPath.section].count) > indexPath.row {
            cellSelects[indexPath.section][indexPath.row].disSelected(indexPath,todos![indexPath.section][indexPath.row])
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        guard self.layout != nil else{
            return
        }
        switch self.layout?.flowLayouttyle {
        case .horPopup(_,_,_)?:
             collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            break
        default: break}
      
//        if self.layout?.scrollDirection == .horizontal{
//            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
//        }
        
    }
    
//    internal func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath){
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath){
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool{
//    }
  
    internal func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
    }
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
    }
    internal func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath){
        
      
    }

    
    internal func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
    }
    internal func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath){
        
    }
//    internal func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?){
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator){
//
//    }
//    internal func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath?{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath{
//
//    }
//    internal func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//    }
//    internal func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool{
//
//    }
    
}
