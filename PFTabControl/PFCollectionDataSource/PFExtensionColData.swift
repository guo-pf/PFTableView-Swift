//
//  PFExtensionColData.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/27.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

extension PFColDataSource : UICollectionViewDataSource{
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.todos != nil else {
            return 0
        }
        return self.todos![section].count
    }
    
    internal func numberOfSections(in collectionView: UICollectionView) -> Int{
        guard self.todos != nil else {
            return 0
        }
        let layout : UICollectionViewFlowLayout = self.owner?.collectionViewLayout as! UICollectionViewFlowLayout
        guard layout.scrollDirection == .vertical else {
            return 1
        }
        return (self.todos?.count)!
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let configure : PFColCellConfigurable?
        if cellConfigs.keys.contains(indexPath) {
            configure = cellConfigs[indexPath]
        }else{
           configure = cellConfig(collectionView, indexPath, self.todos![indexPath.section][indexPath.row])
         //   configure = cellConfig(tableView, indexPath , self.todos!)
            if configure != nil{
                cellConfigs.updateValue(configure!, forKey: indexPath)
            }
        }

        guard configure != nil  else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier!, for: indexPath) as UICollectionViewCell
            let label = UILabel()
            cell.addSubview(label)
           // label.sizeToFit()
            label.text = "数据不匹配。。。"
            label.adjustsFontSizeToFitWidth = true
            editCellConfigure(indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (configure?.cellIdentifier)!, for: indexPath)
        configure?.config(cell)
        cell.backgroundColor = configure?.backgroundColor
        editCellConfigure(configure!,indexPath)
        return cell
        
        
    }
  
    internal func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        if self.layout != nil {
            switch layout?.flowLayouttyle {
            case .horPopup(_,_,_)?:
            if kind == UICollectionElementKindSectionHeader{
                var v = defaultSectionHeardFootView()
                v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: defaultFootIdentifier!, for: indexPath) as? defaultSectionHeardFootView)!
                return v
            }else{
                var v = defaultSectionHeardFootView()
                v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: defaultHeardIdentifier!, for: indexPath) as? defaultSectionHeardFootView)!
                return v
            }
            default: break

            }
        }

        if kind == UICollectionElementKindSectionHeader {
            guard sectionHeardData != nil else{
                var v = defaultSectionHeardFootView()
                v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: defaultHeardIdentifier!, for: indexPath) as? defaultSectionHeardFootView)!
                return v
            }
            
          let config = heardInSectionConfig(collectionView, indexPath.section, sectionHeardData!)
            guard  config != nil && config?.view != nil else{
                var v = defaultSectionHeardFootView()
                v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: defaultHeardIdentifier!, for: indexPath) as? defaultSectionHeardFootView)!
                return v
            }
            if (self.registerHeard.contains((config?.viewIdentifier)!)){
            }else{
                self.registerHeard.append((config?.viewIdentifier)!)
                 self.owner?.register(config?.viewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: (config?.viewIdentifier)!)
            }
            
            let v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: (config?.viewIdentifier)!, for: indexPath))
                v.backgroundColor = config?.backgroundColor
                config?.config(v)
            return v

        }
        
        guard sectionFootData != nil else{
            var v = defaultSectionHeardFootView()
            v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: defaultFootIdentifier!, for: indexPath) as? defaultSectionHeardFootView)!
            
            return v
        }
        let config = footerInSectionConfig(collectionView, indexPath.section, sectionFootData!,(self.todos?.count)!)
        guard  config != nil && config?.view != nil else{
            var v = defaultSectionHeardFootView()
            v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: defaultFootIdentifier!, for: indexPath) as? defaultSectionHeardFootView)!
            return v
        }
      
        if (self.registerFoot.contains((config?.viewIdentifier)!)){
        }else{
            self.registerFoot.append((config?.viewIdentifier)!)
            self.owner?.register(config?.viewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: (config?.viewIdentifier)!)
        }
        
        let v = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: (config?.viewIdentifier)!, for: indexPath))
            v.backgroundColor = config?.backgroundColor
             config?.config(v)
            return v
        
    }
//
//    internal func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool{
//        
//    }
//    
//    internal func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
//        
//    }
//    internal func indexTitles(for collectionView: UICollectionView) -> [String]?{
//        
//    }
//    internal func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath{
//        
//    }
    
    
}
