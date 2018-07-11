//
//  MyControlViewController.swift
//  PFTableView-Swift
//
//  Created by guo-pf on 2018/7/10.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var datas  = MyCollectionDataSource(todos: [],showVer:false,showHor:false, owner: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datas.owner = myCollectionView
        
        NetStore.shared.getColToDoItems { (d, hi, sh, sf, h, f) in
            self.datas.reloadData(d,
                                  itemHeights: hi,
                                  heard: h,
                                  foot: f,
                                  heardInSection: sh,
                                  footInSection: sf)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
