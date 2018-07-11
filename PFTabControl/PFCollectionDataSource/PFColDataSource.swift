//
//  PFColDataSource.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/27.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

class PFColDataSource: NSObject {
    /**
     *flowLayout
     */
    func pfFlowLayoutConfig(_ rowHeights: [[CGFloat]]?,_ heardHeight:CGFloat?,_ footHeight:CGFloat?) -> PFFlowLayoutStyle? {return nil}
    /**
     * 自定义 flowLayout
     */
    func flowLayoutConfig(_ rowHeights: [[CGFloat]]?) -> UICollectionViewFlowLayout? {return nil}
    /**
     * 定义cell
     */
    func cellConfig(_ collection: UICollectionView,_ indexPath: IndexPath ,_ model : Any) -> PFColCellConfigurable?{return nil}
    /**
     * 定义组头
     */
    func heardInSectionConfig(_ collection: UICollectionView,_ section: Int,_ model : [Any]) -> PFColHeardFootConfigurable?{return nil}
    /**
     * 定义组尾
     */
    func footerInSectionConfig(_ collection: UICollectionView,_ section: Int,_ model : [Any], _ maxCount : Int) -> PFColHeardFootConfigurable?{return nil}
    
    /**
     * 定义表头
     */
    func heardView(_ collection: UICollectionView,_ model : Any?) -> PFColHeardFootConfigurable? { return nil }
    /**
     * 定义表尾
     */
    func footView(_ collection: UICollectionView,_ model : Any?) -> PFColHeardFootConfigurable? { return nil }
    
    // 数据刷新
    func reloadData(_ todos:[[Any]]?,
                    itemHeights:[[CGFloat]]? = nil)
    {
        guard self.owner != nil else{
            return
        }
        self.owner?.dataSource = self
        self.todos = todos
        if itemHeights != nil {
            self.rowHeights = itemHeights
        }
        heardViewFootView()
        self.owner?.reloadData()
    }
    // 数据刷新
    func reloadData(_ todos:[[Any]]?,
                    itemHeights:[[CGFloat]]?,
                    heardInSection:[Any]? = nil,
                    footInSection:[Any]? = nil
        ){
        guard self.owner != nil else{
            return
        }
        self.owner?.dataSource = self
        self.todos = todos
        self.rowHeights = itemHeights
        if heardInSection != nil {
             self.sectionHeardData = heardInSection
        }
        if footInSection != nil {
            self.sectionFootData = footInSection
        }
        heardViewFootView()
        self.owner?.reloadData()
    }
    // 数据刷新
    func reloadData(_ todos:[[Any]]?,
                    itemHeights:[[CGFloat]]?,
                    heard:Any? = nil,
                    foot:Any? = nil,
                    heardInSection:[Any]? = nil,
                    footInSection:[Any]? = nil
        ){
        guard self.owner != nil else{
            return
        }
        self.owner?.dataSource = self
        self.todos = todos
        self.rowHeights = itemHeights
        self.heardData = heard
        self.footData = foot
        self.sectionHeardData = heardInSection
        self.sectionFootData = footInSection
        heardViewFootView()
        self.owner?.reloadData()
      }

    private(set)  var heardView : UICollectionReusableView?
    private(set)  var footView : UICollectionReusableView?
    
    private(set) var todos: [[Any]]?
    private(set) var layout : PFColLayout?

    private(set) var showVer : Bool?
    private(set) var showHor : Bool?
    private(set) var heardHeight : CGFloat?
    private(set) var footHeight :  CGFloat?
    lazy var registerHeard = [String]()
    lazy var registerFoot = [String]()
    lazy var cellSelects = [[PFCellSelectable]]()
    lazy var cellConfigs = [IndexPath : PFColCellConfigurable]()
    private(set) var heardData : Any?
    private(set) var footData : Any?
    private(set) var sectionHeardData: [Any]?
    private(set) var sectionFootData: [Any]?
    var tabClassStr : String?  {
        return currentViewController(self.owner!)
    }
    private(set) var rowHeights: [[CGFloat]]?
    weak var owner: UICollectionView?{
        didSet{
            guard owner != nil else{
                return
            }
            self.owner?.delegate = self
            if showVer != nil {
                self.owner?.showsVerticalScrollIndicator = showVer!
            }
            if showHor != nil {
                self.owner?.showsHorizontalScrollIndicator = showHor!
            }
 
            let baseColName = String.init(utf8String: object_getClassName(self.owner))
            let identifier = (baseColName?.count)! > 0 ?  baseColName : "collectionview"
            let  footIdentifier = (baseColName?.count)! > 0 ?  baseColName : "colFooterview"
            let  heardIdentifier = (baseColName?.count)! > 0 ?  baseColName : "colHeardview"
            defaultHeardIdentifier = (tabClassStr! + heardIdentifier!).components(separatedBy: ".").reduce("") {
                return $0 == "" ? $1 : $0 + $1
            }
            defaultFootIdentifier = (tabClassStr! + footIdentifier!).components(separatedBy: ".").reduce("") {
                return $0 == "" ? $1 : $0 + $1
            }
            defaultCellIdentifier = (tabClassStr! + identifier!).components(separatedBy: ".").reduce("") {
                return $0 == "" ? $1 : $0 + $1
            }
            self.owner?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: defaultCellIdentifier!)
             self.owner?.register(defaultSectionHeardFootView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: defaultHeardIdentifier!)
             self.owner?.register(defaultSectionHeardFootView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: defaultFootIdentifier!)
        }
    }
    
    private(set) var defaultCellIdentifier : String?
    private(set) var defaultHeardIdentifier : String?
    private(set) var defaultFootIdentifier : String?
    private let risgterClass = ColInitRisgterClass()
    init(todos: [[Any]],
         showVer:Bool? = false,
         showHor:Bool? = false,
         owner: UICollectionView?) {
        self.todos = todos
        self.owner = owner
        self.showVer = showVer
        self.showHor = showHor
       
        super.init()
        risgterClass.initRisgter()
        
    }
}
extension PFColDataSource {
    
func editCellConfigure(_ indexPath: IndexPath){
    let noneSelect : PFCellSelectable? = PFCellSelectedAction { (indexPath,model) in
        
    }
    if (cellSelects.count) > indexPath.section {
        if (cellSelects[indexPath.section].count) > indexPath.row{
        }else{
            
            cellSelects[indexPath.section].append(noneSelect!)
        }
    }else{
        cellSelects.append([noneSelect!])
    }
}

func editCellConfigure(_ configure: PFColCellConfigurable, _ indexPath: IndexPath){
   
    if (cellSelects.count) > indexPath.section {
        if (cellSelects[indexPath.section].count) > indexPath.row{
        }else{
           
            cellSelects[indexPath.section].append(configure.selection!)
        }
    }else{
        cellSelects.append([configure.selection!])
    }
}
  
fileprivate func heardViewFootView(){
    let heardConfig = heardView(self.owner!, heardData as Any)
    let footConfig = footView(self.owner!, footData as Any)
    let config = pfFlowLayoutConfig(self.rowHeights,heardConfig?.height,footConfig?.height)
    if config != nil {
        layout = PFColLayout(flowLayouttyle: config)
        self.owner?.collectionViewLayout = layout!
        if layout?.scrollDirection == .vertical{  
            heardHeight = layout?.heardHeight
            footHeight = layout?.footHeight
            if heardView != nil{
                heardView?.removeFromSuperview()
            }
            if footView != nil{
                footView?.removeFromSuperview()
            }
            if heardConfig != nil{
                heardView = heardConfig?.view ?? UICollectionReusableView()
                heardView?.frame = CGRect(x: 0, y: 0, width: (self.owner?.frame.size.width)!, height: heardHeight!)
                heardConfig?.config(heardView!)
                if !((self.owner?.subviews.contains(heardView!)))!{
                    self.owner?.addSubview(heardView!)
                }
            }
            if footConfig != nil {
                footView = footConfig?.view ?? UICollectionReusableView()
                footView?.frame = CGRect(x: 0, y: 0, width: (self.owner?.frame.size.width)!, height: self.footHeight!)
                if !(self.owner?.subviews.contains(footView!))!{
                    self.owner?.addSubview(footView!)
                }
                layout?.requstFootFrameY(comMaxHeight: { (y) in
                    self.footView?.frame = CGRect(x: 0, y: y, width: (self.owner?.frame.size.width)!, height: self.footHeight!)
                    footConfig?.config(self.footView!)
                })
            }
            
        }
    }else{
        let userLayout = flowLayoutConfig(rowHeights)
        if userLayout != nil{
            self.owner?.collectionViewLayout = userLayout ?? UICollectionViewFlowLayout()
            if heardView != nil{
                heardView?.removeFromSuperview()
            }
            if heardConfig != nil{
                heardView = heardConfig?.view ?? UICollectionReusableView()
                heardHeight = heardConfig?.height
                heardView?.frame = CGRect(x: 0, y: 0, width: (self.owner?.frame.size.width)!, height: heardHeight!)
                heardConfig?.config(heardView!)
                if !((self.owner?.subviews.contains(heardView!)))!{
                    self.owner?.addSubview(heardView!)
                }
            }
            
            
        }
     }
    
    
 }
    
    
  fileprivate  func currentViewController(_ view: UIView)-> String? {
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

class defaultSectionHeardFootView : UICollectionReusableView {}

