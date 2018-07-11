//
//  MyCollectionDataSource.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class MyCollectionDataSource: PFColDataSource {
    // 可以自定义FlowLayout
    //    override func flowLayoutConfig(_ rowHeights: [[CGFloat]]?) -> UICollectionViewFlowLayout? {
    //        let flowLayout = UICollectionViewFlowLayout()
    //        flowLayout.scrollDirection = .horizontal
    //        flowLayout.itemSize = CGSize(width: 200, height: 200)
    //        flowLayout.minimumLineSpacing = 1
    //        flowLayout.minimumInteritemSpacing = 40
    //        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    //        flowLayout.headerReferenceSize = CGSize(width: 0, height: 100)
    //        flowLayout.footerReferenceSize = CGSize(width: 0, height: 60)
    //
    //        return flowLayout
    //    }
    //这里给了几种类型，基本涵盖了
    override func pfFlowLayoutConfig(_ rowHeights: [[CGFloat]]?,_ heardHeight:CGFloat?,_ footHeight:CGFloat?) -> PFFlowLayoutStyle?{
        //        -------------横滚，中间的大，两边的小，但不分组，自动只获取第一组数据----------------------
        //        return PFFlowLayoutStyle.horPopup(itemSize: CGSize(width: 200 ,
        //                                                           height: 300),
        //                                          scale: 0.6,
        //                                          spacing: 30)
        //     ---------------横滚，普通式样，都一样大小，但不分组，自动只获取第一组数据------------------------------
        //        return PFFlowLayoutStyle.carousel(itemSize: CGSize(width: 100 , height: 100),
        //                                          isPag: false,
        //                                          miniLineSpac: 100,
        //                                          miniItemSpac: 10,
        //                                          insets: UIEdgeInsets(top: 100, left: 10, bottom: 100, right: 10))
        //        -------------竖滚，瀑布流，但需要提前计算好高度----------------------
        return PFFlowLayoutStyle.waterfallFlow(
            rowHeights: rowHeights,
            cols: 3,
            heardHeight: heardHeight,
            footHeight : footHeight,
            sectionHeardHeight:50,
            sectionFootHeight: 20,
            heardFootStyle: .all,
            miniLineSpac: 10,
            miniItemSpac: 10,
            insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        //        -------------竖滚，定义好宽高比例 ----------------------
        //        return PFFlowLayoutStyle.verticalSection(cols: 3,
        //                                                 widHeiScale: 3.0/2.0,
        //                                                 heardHeight: heardHeight,
        //                                                 footHeight: footHeight,
        //                                                 sectionHeardHeight: 50,
        //                                                 sectionFootHeight: 20,
        //                                                 heardFootStyle: .all,
        //                                                 miniLineSpac: 10,
        //                                                 miniItemSpac: 10,
        //                                                 insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
    }

    override func cellConfig(_ collection: UICollectionView,_ indexPath: IndexPath ,_ model : Any) -> PFColCellConfigurable?{
        
        if let myModel = model as? ColOneCellModel {
            return PFColCellConfigurator<ColOneCollectionViewCell>(viewModel: myModel,
                                                                    backgroundColor: .red,
                                                                    collectionView: collection,
                                                                    selection: PFCellSelectedAction(selectedAction: { (indexPath,model) in
                                                                       
                                                                        
                                                                        
                                                                    }), complate: { (result) in
                                                                        print(result)
            })
            
        }
        return nil
        
    }
    
    /**
     * 定义组头
     */
    override func heardInSectionConfig(_ collection: UICollectionView,_ section: Int,_ model : [Any]) -> PFColHeardFootConfigurable?{
        if let myModel = model[0] as? ColHeardInSectionModel {
            let vc = ColHeardInSectionView()
            return  PFColHeardFootConfigurator<ColHeardInSectionView>(viewModel: myModel,
                                                                     backgroundColor: .black,
                                                                     view: vc,
                                                                     complate: { (result) in
                                                                        
            })
        }
        return nil
    }
    //    /**
    //     * 定义组尾
    //     */
        override func footerInSectionConfig(_ collection: UICollectionView,_ section: Int,_ model : [Any], _ maxCount : Int) -> PFColHeardFootConfigurable?{
                if let myModel = model[0] as? ColFootInSectionModel {
                    let vc = ColFootInSectionView()
                    return  PFColHeardFootConfigurator<ColFootInSectionView>(viewModel: myModel,
                                                                            backgroundColor: .blue,
                                                                            view: vc,
                                                                            complate: { (result) in
    
                    })
                }
            return nil
        }
    /**
     * 定义表头
     */
    override func heardView(_ collection: UICollectionView,_ model : Any?) -> PFColHeardFootConfigurable? {
        let vc = ColHeardView()
        return  PFColHeardFootConfigurator<ColHeardView>(viewModel: model != nil ?  (model as? ColHeardModel) : nil,
                                                          backgroundColor: .brown,
                                                          view: vc,
                                                          height:100,
                                                          complate: { (result) in
                                                            
        })
        
    }
    /**
     * 定义表尾
     */
    override func footView(_ collection: UICollectionView,_ model : Any?) -> PFColHeardFootConfigurable? {
        let vc = ColFootView()
        return  PFColHeardFootConfigurator<ColFootView>(viewModel: model != nil ?  (model as? ColFootModel) : nil,
                                                         backgroundColor: .purple,
                                                         view: vc,
                                                         height:60,
                                                         complate: { (result) in
                                                            
        })
    }


}
