//
//  PFTabDataSource.swift
//  TableViewDemo
//
//  Created by guo-PFTab on 2018/6/20.
//  Copyright © 2018年 guo-PFTab. All rights reserved.
//

import UIKit

class PFTabDataSource: NSObject{
    /**
    * 定义cell
    */
    func cellConfig(_ tableView: UITableView,_ indexPath: IndexPath ,_ model : Any) -> PFTabCellConfigurable?{return nil}
    /**
     * 定义组头
     */
    func heardInSectionConfig(_ tableView: UITableView,_ section: Int,_ model : [Any], _ maxCount : Int ) -> PFTabHeardFootConfigurable?{return nil}
    /**
     * 定义组尾
     */
    func footerInSectionConfig(_ tableView: UITableView,_ section: Int,_ model : [Any], _ maxCount : Int ) -> PFTabHeardFootConfigurable?{return nil}
    /**
     * 定义表头
     */
    func heardView(_ tableView: UITableView,_ model : Any?) -> PFTabHeardFootConfigurable? { return nil }
    /**
     * 定义表尾
     */
    func footView(_ tableView: UITableView,_ model : Any?) -> PFTabHeardFootConfigurable? { return nil }
    
    func reloadData(_ todos:[[Any]]?){
        self.owner?.dataSource = self
        self.todos = todos
        self.owner?.reloadData()
    }
    func reloadData(_ todos:[[Any]]?,
                    heardInSection:[Any]? = nil,
                    footInSection:[Any]? = nil){
        self.owner?.dataSource = self
        self.todos = todos
        self.heardInSectionData = heardInSection
        self.footInSectionData = footInSection
        self.owner?.reloadData()
    }
    
    func reloadData(_ todos:[[Any]]?,
                    heard:Any? = nil,
                    foot:Any? = nil,
                    heardInSection:[Any]? = nil,
                    footInSection:[Any]? = nil
        ){
        self.owner?.dataSource = self
        self.todos = todos
        self.heardInSectionData = heardInSection
        self.footInSectionData = footInSection
        self.heardData = heard
        self.footData = foot

        self.owner?.tableHeaderView?.removeFromSuperview()
        let hConfigure = heardView(self.owner!, heardData)
        hConfigure?.view?.frame = CGRect(x: 0, y: 0, width:(self.owner?.frame.size.width)!, height: (hConfigure?.height)!)
        self.owner?.tableHeaderView = hConfigure?.view
        hConfigure?.config((hConfigure?.view)!)

        self.owner?.tableFooterView?.removeFromSuperview()
        let fConfigure = footView(self.owner!, footData)
        fConfigure?.view?.frame = CGRect(x: 0, y: 0, width:(self.owner?.frame.size.width)!, height: (fConfigure?.height)!)
        self.owner?.tableFooterView = fConfigure?.view
        fConfigure?.config((fConfigure?.view)!)
        
        self.owner?.reloadData()
        
    }

     private(set) var todos: [[Any]]?
     private(set) var heardInSectionData: [Any]?
     private(set) var footInSectionData: [Any]?
    
     lazy var rowHeights = [[CGFloat]]()
     lazy var lightHeights = [[CGFloat]]()
     lazy var cellSelects = [[PFCellSelectable]]()
     lazy var heards = [Int : PFTabHeardFootConfigurable?]()
     lazy var foots = [Int : PFTabHeardFootConfigurable?]()
     lazy var cellConfigs = [IndexPath : PFTabCellConfigurable]()
     private(set) var defaultCellIdentifier : String?
     private var heardData : Any?
     private var footData : Any?
     private let risgterClass = TabInitRisgterClass()
     weak var owner: UITableView?{
        didSet{
            guard owner != nil else{
                return
            }
            self.owner?.delegate = self
            self.owner?.separatorStyle = .none
            var  identifier =  String.init(utf8String: object_getClassName(self.owner))
            identifier = (identifier?.count)! > 0 ?  identifier : "tableview"
            let tabClassStr  = currentViewController(self.owner!)
            defaultCellIdentifier = (tabClassStr! + identifier!).components(separatedBy: ".").reduce("") {
                return $0 == "" ? $1 : $0 + $1
            }
            self.owner?.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier!)

        }
     }

   
    init(todos: [[Any]],
         owner: UITableView?) {
         self.todos = todos
         self.owner = owner
         super.init()
        risgterClass.initRisgter()

    }
   
}

extension PFTabDataSource {
     func editCellConfigure(_ configure: PFTabCellConfigurable, _ indexPath: IndexPath){
        if (rowHeights.count) > indexPath.section {
            if (rowHeights[indexPath.section].count) > indexPath.row{
            }else{
                rowHeights[indexPath.section].append(configure.height)
                 lightHeights[indexPath.section].append(configure.lightHeight!)
                cellSelects[indexPath.section].append(configure.selection!)
            }
        }else{
            rowHeights.append([configure.height])
            lightHeights.append([configure.lightHeight!])
            cellSelects.append([configure.selection!])
        }
    }
    
    func editCellConfigure(_ height: CGFloat, _ indexPath: IndexPath){
        let noneSelect : PFCellSelectable? = PFCellSelectedAction { (indexPath,model) in
            
        }
        if (rowHeights.count) > indexPath.section {
            if (rowHeights[indexPath.section].count) > indexPath.row{
            }else{
                rowHeights[indexPath.section].append(height)
                lightHeights[indexPath.section].append(height)
                cellSelects[indexPath.section].append(noneSelect!)
            }
        }else{
            rowHeights.append([height])
            lightHeights.append([height])
            cellSelects.append([noneSelect!])
        }
    }
    
    func currentViewController(_ view: UIView)-> String? {
        var next:UIView? = view
        repeat{
            if let nextResponder = next?.next, nextResponder.isKind(of: UIViewController.self)
            {
                return  NSStringFromClass(type(of: nextResponder))
                //   return (nextResponder as! UIViewController)
                
            }
            next = next?.superview
            
        }while next != nil
        
        return nil
        
    }
 
}


