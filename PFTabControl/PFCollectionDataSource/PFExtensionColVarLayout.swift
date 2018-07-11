//
//  PFExtensionColVarLayout.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/29.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

//横向
extension PFColLayout {

    func  layoutAttributesForElements(_ layoutAttributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes]?{
        let array = layoutAttributes
        //可见矩阵
        let visiableRect = CGRect(x: self.collectionView!.contentOffset.x, y: self.collectionView!.contentOffset.y, width: self.collectionView!.frame.width, height: self.collectionView!.frame.height)
    
       
        //接下来的计算是为了动画效果
       // let maxCenterMargin = self.collectionView!.bounds.width * 0.5 + self.itemSize.width * 0.5 + self.minimumLineSpacing
        let maxCenterMargin = self.itemSize.width + self.minimumLineSpacing
        //获得collectionVIew中央的X值(即显示在屏幕中央的X)
         let centerX = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width * 0.5;
//        for attributes in array {
//            //如果不在屏幕上，直接跳过
//            if !CGRectIntersectsRect(visiableRect, attributes.frame) {continue}
//            let scale = 1 + (0.8 - abs(centerX - attributes.center.x) / maxCenterMargin)
//            attributes.transform = CGAffineTransformMakeScale(scale, scale)
//        }
         for attributes in array {
            if !visiableRect.intersects(attributes.frame) {continue}
            let maxH = self.itemSize.height
            let minH = self.itemSize.height * scale!
            var nowH = minH
            if abs(centerX - attributes.center.x) <= maxCenterMargin{
                nowH =  (maxH-minH) * (1 - abs(centerX - attributes.center.x) / maxCenterMargin) + minH
            }else{
                nowH = minH
            }
           
            let iScale = nowH/maxH
        
            print(iScale)
            attributes.transform = CGAffineTransform(scaleX: iScale, y: iScale)
        }
        
        return array
    }
    
     func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        //实现这个方法的目的是：当停止滑动，时刻有一张图片是位于屏幕最中央的。
       
        let lastRect =  CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: self.collectionView!.frame.width, height: self.collectionView!.frame.height)
        //获得collectionVIew中央的X值(即显示在屏幕中央的X)
        let centerX = proposedContentOffset.x + self.collectionView!.frame.width * 0.5;
        //这个范围内所有的属性
        let array = self.layoutAttributesForElements(in: lastRect)
        
        //需要移动的距离
        var adjustOffsetX = CGFloat(MAXFLOAT);
        for attri in array! {
            if abs(attri.center.x - centerX) < abs(adjustOffsetX) {
                adjustOffsetX = attri.center.x - centerX;
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
    }
    
    
    
}
