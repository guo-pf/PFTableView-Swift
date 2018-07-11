//
//  PFExtensionColLayout.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/29.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

//纵向
extension PFColLayout{
    func header_LayoutAttributesForSupplementaryView(_ attributes: UICollectionViewLayoutAttributes,
                                                     _ frame:CGRect,
                                                     _ indexPath: IndexPath) -> UICollectionViewLayoutAttributes?  {
        let layoutAttributes = attributes
        var frameForSupplementaryView = frame
        if (self.sectionHeardFrameY.count) > layoutAttributes.indexPath.section {
            switch self.heardFootStyle{
            case .all?:
                break
            case .firstAndLast?:
                if(indexPath.section != 0){
                    frameForSupplementaryView.size.height = 0
                }
                break
            case .heardAllFootLast?:
                break
            case .footAllHeardFirst?:
                if(indexPath.section != 0){
                    frameForSupplementaryView.size.height = 0
                }
                break
            case .heardFirstFootAllExceptLast?:
                if(indexPath.section != 0){
                    frameForSupplementaryView.size.height = 0
                }
                break
            default:
                frameForSupplementaryView.size.height = 0
                break
                
            }
            frameForSupplementaryView.origin.y = self.sectionHeardFrameY[layoutAttributes.indexPath.section]
        }
        //更新布局属性并返回
        layoutAttributes.frame = frameForSupplementaryView
        return layoutAttributes
        
    }
    func foot_LayoutAttributesForSupplementaryView(_ attributes: UICollectionViewLayoutAttributes,
                                                   _ frame:CGRect,
                                                   _ indexPath: IndexPath) -> UICollectionViewLayoutAttributes?  {
        let layoutAttributes = attributes
        var frameForSupplementaryView = frame
        if (self.sectionFooterFrameY.count) > layoutAttributes.indexPath.section {
            
            switch self.heardFootStyle{
            case .all?:
                break
            case .firstAndLast?:
                if(indexPath.section != (self.sectionFooterFrameY.count) - 1){
                    frameForSupplementaryView.size.height = 0
                }
                break
            case .heardAllFootLast?:
                if(indexPath.section != (self.sectionFooterFrameY.count)-1){
                    frameForSupplementaryView.size.height = 0
                }
                break
            case .footAllHeardFirst?:
                break
            case .heardFirstFootAllExceptLast?:
                if(indexPath.section == (self.sectionFooterFrameY.count)-1){
                    frameForSupplementaryView.size.height = 0
                }
                break
            default:
                frameForSupplementaryView.size.height = 0
                break
            }
            frameForSupplementaryView.origin.y = self.sectionFooterFrameY[layoutAttributes.indexPath.section]
        }
        //更新布局属性并返回
        layoutAttributes.frame = frameForSupplementaryView
        return layoutAttributes
        
    }
}

extension PFColLayout {

    
    func doVerticalSection_LayoutAttributesForElements(_ layoutAttributes : [UICollectionViewLayoutAttributes],
                                                       _ cols:Int,
                                                       _ widHeiScale : CGFloat,
                                                       _ heardHeight : CGFloat ,
                                                       _ footHeight : CGFloat) -> [UICollectionViewLayoutAttributes]? {
        let itemW:CGFloat = (collectionView!.bounds.size.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*CGFloat(cols - 1))/CGFloat(cols)
        
        //用于存储元素新的布局属性,最后会返回这个
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
        //存储每个layout attributes对应的是哪个section
        let sectionsToAdd = NSMutableIndexSet()
        
        //循环老的元素布局属性
        var section = 0
        let hDx = self.headerReferenceSize.height
        let fDx = self.footerReferenceSize.height
        initHeights(hDx)
        for i in 0..<layoutAttributes.count{
            let layoutAttributesSet = layoutAttributes[i]
            if layoutAttributesSet.representedElementCategory == .cell {
                //将布局添加到newLayoutAttributes中
                let itemH:CGFloat = itemW / widHeiScale
                let indexPath = layoutAttributesSet.indexPath
                if section != indexPath.section{
                    let maxH = heights.max()!
                    let bootm : CGFloat =  0.0
                    heightsHeardsFootsLayout(hDx, fDx, maxH, bootm)
                    section = indexPath.section
                }
                
                let height = heights.min()!
                let index = heights.index(of: height)!
                
                let itemX = sectionInset.left + (itemW + minimumInteritemSpacing)*CGFloat(index)
                
                let itemY:CGFloat = height + minimumLineSpacing
                
                //设置attr的frame
                layoutAttributesSet.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                //保存heights
                heights[index] = height + minimumLineSpacing + itemH
                
                newLayoutAttributes.append(layoutAttributesSet)
                
            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
                //将对应的section储存到sectionsToAdd中
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            }
        }
        
        footerLayout(fDx,footHeight)
        return  sectionsToAddData(sectionsToAdd,newLayoutAttributes)

        
    }

    
    func doWaterfallFlow_LayoutAttributesForElements(_ layoutAttributes : [UICollectionViewLayoutAttributes],
                                                     _ cols:Int,
                                                     _ rowHeights:[[CGFloat]],
                                                     _ heardHeight : CGFloat ,
                                                     _ footHeight : CGFloat) -> [UICollectionViewLayoutAttributes]?{
        let itemW:CGFloat = (collectionView!.bounds.size.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*CGFloat(cols - 1))/CGFloat(cols)
        
        //用于存储元素新的布局属性,最后会返回这个
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
        //存储每个layout attributes对应的是哪个section
        let sectionsToAdd = NSMutableIndexSet()
        
        //循环老的元素布局属性
        var section = 0
        let hDx = self.headerReferenceSize.height
        let fDx = self.footerReferenceSize.height
        initHeights(hDx)
        for i in 0..<layoutAttributes.count{
            let layoutAttributesSet = layoutAttributes[i]
            if layoutAttributesSet.representedElementCategory == .cell {
                //将布局添加到newLayoutAttributes中
                let indexPath = layoutAttributesSet.indexPath
                var itemH:CGFloat = 0.0
                
                if (rowHeights.count) > indexPath.section{
                    if rowHeights[indexPath.section].count > indexPath.row {
                        itemH = rowHeights[section][indexPath.row]
                    }else{
                        itemH = rowHeights[section].last!
                    }
                }else{
                    if (rowHeights.last?.count)! > indexPath.row {
                        itemH = rowHeights.last![indexPath.row]
                    }else{
                        itemH = (rowHeights.last?.last)!
                    }
                }
                
                if section != indexPath.section{
                    let maxH = heights.max()!
                    let bootm : CGFloat =  0.0
                     heightsHeardsFootsLayout(hDx, fDx, maxH, bootm)
                    section = indexPath.section
                }
                let height = heights.min()!
                let index = heights.index(of: height)!
                
                let itemX = sectionInset.left + (itemW + minimumInteritemSpacing)*CGFloat(index)
                
                let itemY:CGFloat = height + minimumLineSpacing
                
                //设置attr的frame
                layoutAttributesSet.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                //保存heights
                heights[index] = height + minimumLineSpacing + itemH
                
                newLayoutAttributes.append(layoutAttributesSet)
                
            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
                //将对应的section储存到sectionsToAdd中
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            }
        }
        footerLayout(fDx,footHeight)
      return  sectionsToAddData(sectionsToAdd,newLayoutAttributes)
        
    }
    
    func initHeights(_ hDx : CGFloat) {
        
        if heardFootStyle != PFFlowLayoutSectionFootHeardStyle.none {
            for j in 0..<heights.count{
                heights[j] = hDx + heardHeight!
            }
        }else{
            for j in 0..<heights.count{
                heights[j] = heardHeight!
            }
        }
        if heardHeight! > 0.0 {
            sectionHeardFrameY.removeAll()
            sectionHeardFrameY.append(heardHeight!)
        }
        
        sectionFooterFrameY.removeAll()
    }
    
    func sectionsToAddData(_ sectionsToAdd: NSMutableIndexSet,
                       _ layoutAttributes:[UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        var newLayoutAttributes = layoutAttributes
        //遍历sectionsToAdd，补充视图使用正确的布局属性
        for section in sectionsToAdd {
            let indexPath = IndexPath(item: 0, section: section)
            
            //添加头部布局属性
            if let headerAttributes = self.layoutAttributesForSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, at: indexPath) {
                newLayoutAttributes.append(headerAttributes)
            }
            
            //添加尾部布局属性
            if let footerAttributes = self.layoutAttributesForSupplementaryView(ofKind:
                UICollectionElementKindSectionFooter, at: indexPath) {
                newLayoutAttributes.append(footerAttributes)
            }
        }
        return newLayoutAttributes
        
    }

    func heightsHeardsFootsLayout( _ hDx : CGFloat,
                                   _ fDx: CGFloat,
                                   _ maxH : CGFloat,
                                   _ sbootm : CGFloat )  {
        var bootm = sbootm
        switch self.heardFootStyle{
        case .all?:
            if hDx > 0{
                bootm =  minimumLineSpacing
                sectionHeardFrameY.append(maxH + bootm + fDx)
            }
            if fDx > 0{
                sectionFooterFrameY.append(maxH + bootm)
            }
            for j in 0..<heights.count{
                heights[j] = maxH + hDx + bootm + fDx
            }
            
            break
        case .firstAndLast?:
            for j in 0..<heights.count{
                heights[j] = maxH + bootm
            }
            sectionHeardFrameY.append(0.0)
            sectionFooterFrameY.append(0.0)
            break
        case .heardAllFootLast?:
            if hDx > 0{
                bootm =  minimumLineSpacing
                sectionHeardFrameY.append(maxH + bootm)
            }
            sectionFooterFrameY.append(0)
            for j in 0..<heights.count{
                heights[j] = maxH + hDx + bootm
            }
            
            break
        case .footAllHeardFirst?:
            
            sectionHeardFrameY.append(0)
            
            if fDx > 0{
                bootm =  minimumLineSpacing
                sectionFooterFrameY.append(maxH + bootm)
            }
            for j in 0..<heights.count{
                heights[j] = maxH  + bootm + fDx
            }
            break
        case .heardFirstFootAllExceptLast?:
            sectionHeardFrameY.append(0.0)
            if fDx > 0{
                bootm =  minimumLineSpacing
                sectionFooterFrameY.append(maxH + bootm)
            }
            for j in 0..<heights.count{
                heights[j] = maxH  + bootm + fDx
            }
            break
        default:
            bootm =  minimumLineSpacing
            sectionHeardFrameY.append(0.0)

            sectionFooterFrameY.append(0.0)
           
            for j in 0..<heights.count{
                heights[j] = maxH  + bootm
            }
            break
        }
        
    }

    func footerLayout(_ fDx : CGFloat,_ footHeight: CGFloat){
        switch self.heardFootStyle{
        case .all? , .firstAndLast? , .heardAllFootLast?, .footAllHeardFirst?:
            let height = heights.max()!
            let index = heights.index(of: height)!
            heights[index] = height + fDx + minimumLineSpacing + footHeight
            sectionFooterFrameY.append(height + minimumLineSpacing)
            break
        default:
            sectionFooterFrameY.append(0.0)
            break
        }
    }
}

