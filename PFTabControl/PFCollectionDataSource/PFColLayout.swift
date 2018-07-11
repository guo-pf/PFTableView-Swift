//
//  PFColLayout.swift
//  TableViewDemo
//
//  Created by guo-pf on 2018/6/27.
//  Copyright © 2018年 guo-pf. All rights reserved.
//

import UIKit

enum PFFlowLayoutSectionFootHeardStyle{
    case none                           //没有头尾
    case all                            //所有组头尾都有
    case firstAndLast                   //只有第一个头和最后一个尾有
    case heardAllFootLast               //组头都有，尾只有最后一个
    case footAllHeardFirst              //尾都有，组头只有第一个
    case heardFirstFootAllExceptLast    //头第一个，尾除了最后都有
}

enum PFFlowLayoutStyle {
    /**
     * 横向滚动视图,中间的大，周边的小
     */
    case horPopup(itemSize:CGSize?,scale:CGFloat,spacing: CGFloat?)
    /**
     * 横向滚动视图
     */
    case carousel(itemSize:CGSize?,
        isPag:Bool?,
        miniLineSpac:CGFloat?,
        miniItemSpac:CGFloat?,
        insets: UIEdgeInsets?)
    
    
    /**
     * 普通纵向 宽高比例设置进行计算
     */
    
    case verticalSection(cols : Int?,
        widHeiScale:CGFloat?,
        heardHeight:CGFloat?,
        footHeight:CGFloat?,
        sectionHeardHeight:CGFloat?,
        sectionFootHeight:CGFloat?,
        heardFootStyle:PFFlowLayoutSectionFootHeardStyle?,
        miniLineSpac:CGFloat?,
        miniItemSpac:CGFloat?,
        insets: UIEdgeInsets?)
    /**
     * 瀑布流纵向 若heights数组中只一个高度的话，则 每个高度都一样
     */
    case waterfallFlow(rowHeights:[[CGFloat]]? ,
        cols : Int?,
        heardHeight:CGFloat?,
        footHeight:CGFloat?,
        sectionHeardHeight:CGFloat?,
        sectionFootHeight:CGFloat?,
        heardFootStyle:PFFlowLayoutSectionFootHeardStyle?,
        miniLineSpac:CGFloat?,
        miniItemSpac:CGFloat?,
        insets: UIEdgeInsets?)
}

class PFColLayout: UICollectionViewFlowLayout,UIScrollViewDelegate {

    lazy var attrs:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    private(set) var sectionHeardHeight:CGFloat?
    private(set) var sectionFootHeight:CGFloat?
    private(set) var heardHeight:CGFloat?
    private(set) var footHeight:CGFloat?
    private(set) var maxHeight : CGFloat?
    private(set) var heardFootStyle:PFFlowLayoutSectionFootHeardStyle? = .all
    
    lazy var heights:[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols!)
    private var rowHeights: [[CGFloat]]?
    private var isPag:Bool? = false
    private var cols : Int?
    private var insets: UIEdgeInsets?
    private(set) var  flowLayouttyle : PFFlowLayoutStyle?
    private var widHeiScale : CGFloat?
    private(set) var scale : CGFloat?
    private var spacing : CGFloat?
    
    private(set) var comMaxHeight : ((_ maxHeight:CGFloat) -> Void)?
    
    var sectionHeardFrameY = [CGFloat]()
    var sectionFooterFrameY = [CGFloat]()
    
    init(flowLayouttyle : PFFlowLayoutStyle? = nil) {
        super.init()
        guard flowLayouttyle != nil else{
            return
        }
        self.flowLayouttyle = flowLayouttyle
        switch flowLayouttyle {
        case .waterfallFlow(let rowHeights,let cols,let heardHeight,let footHeight,let sectionHeardHeight,let sectionFootHeight,let heardFootStyle,let  miniLineSpac,let  miniItemSpac,let  insets)?:
            doWaterfallFlow(rowHeights, cols,heardHeight,footHeight, sectionHeardHeight,sectionFootHeight,heardFootStyle, miniLineSpac, miniItemSpac, insets)
            break
        case .verticalSection(let cols, let widHeiScale,let heardHeight,let footHeight,let sectionHeardHeight,let sectionFootHeight,let heardFootStyle, let miniLineSpac, let miniItemSpac, let insets)?:
            doVerticalSection(cols, widHeiScale,heardHeight,footHeight,sectionHeardHeight,sectionFootHeight,heardFootStyle, miniLineSpac, miniItemSpac, insets)
            break
        case .carousel(let itemSize,let isPag, let miniLineSpac,let miniItemSpac,let insets)?:
            doCarousel(itemSize,isPag, miniLineSpac, miniItemSpac, insets)
            break
        case .horPopup(let itemSize,let scale,let spacing)?:
            doHorPopup(itemSize, scale, spacing)
            break
        default:
            break
        }
    }

    func requstFootFrameY(comMaxHeight:@escaping (_ masHeight:CGFloat) -> ()) {
        self.comMaxHeight = comMaxHeight
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension PFColLayout
{
    override func prepare() {
        super.prepare()
        
        if scrollDirection == .vertical {
            self.headerReferenceSize = CGSize(width:(collectionView?.frame.size.width)!, height: sectionHeardHeight!)
            self.footerReferenceSize = CGSize(width:(collectionView?.frame.size.width)!, height: sectionFootHeight!)
        }else{
            if itemSize == CGSize(width: 0, height: 0){
               itemSize = CGSize(width: (collectionView?.frame.size.width)!, height: (collectionView?.frame.size.height)!)
            }
            
            switch self.flowLayouttyle {
            case .horPopup(_,_,_)?:
                self.headerReferenceSize = CGSize(width:(collectionView?.frame.size.width)!/2 - itemSize.width/2, height: itemSize.height)
                self.footerReferenceSize = CGSize(width:(collectionView?.frame.size.width)!/2 - itemSize.width/2, height: itemSize.height)
            default: break

            }

          
              collectionView?.isPagingEnabled = isPag!
        }
    }
}


extension PFColLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //从父类得到默认的所有元素属性
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect)
            else { return nil }
        guard scrollDirection == .vertical else{
           switch self.flowLayouttyle {
           case .horPopup(_,_,_)?:
            return layoutAttributesForElements(layoutAttributes)
           default:
            return layoutAttributes

            }

        }
        guard attrs.count <= 0 else {
            return attrs
        }
        switch  self.flowLayouttyle {
        case .waterfallFlow(_,_,_,_,_,_,_,_,_,_)?:
            attrs = doWaterfallFlow_LayoutAttributesForElements(layoutAttributes,cols!,rowHeights!,heardHeight!,footHeight!)!
            break
        case .verticalSection(_,_,_,_,_,_,_,_,_,_)?:
            attrs = doVerticalSection_LayoutAttributesForElements(layoutAttributes,cols!,widHeiScale!,heardHeight!,footHeight!)!
            break
       default:
            break
        }
        
         return attrs
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        
        switch self.flowLayouttyle {
        case .horPopup(_,_,_)?:
           return targetContentOffsetForProposedContentOffset(proposedContentOffset: proposedContentOffset)
        default:
             return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
       
    }
    

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String,
                                                       at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind:
            elementKind, at: indexPath) else { return nil }
        
        guard scrollDirection == .vertical else{
            
            switch self.flowLayouttyle {
            case .horPopup(_,_,_)?:
                return layoutAttributes
            default:
                return layoutAttributes
                
            }
            
        }
        
        //如果不是头部视图则直接返回
        if elementKind != UICollectionElementKindSectionHeader {
            guard collectionView != nil else { return layoutAttributes }

            //补充视图的frame
            let frameForSupplementaryView = layoutAttributes.frame
            return   foot_LayoutAttributesForSupplementaryView(layoutAttributes, frameForSupplementaryView, indexPath)

        }
        guard collectionView != nil else { return layoutAttributes }
        //补充视图的frame
        let frameForSupplementaryView = layoutAttributes.frame
        
        return   header_LayoutAttributesForSupplementaryView(layoutAttributes, frameForSupplementaryView, indexPath)

    }
    
    override var collectionViewContentSize: CGSize{
       
        if scrollDirection == .horizontal {  //横向滚动
            let size = super.collectionViewContentSize
            return size
        }
        if maxHeight != heights.max()! {
             maxHeight = heights.max()!
            if self.comMaxHeight != nil{
                 self.comMaxHeight!(maxHeight! - footHeight!)
            }
        }
       
        //竖向滚动
        return CGSize(width: (collectionView?.frame.size.width)!, height: heights.max()! + sectionInset.bottom)
    }
    //边界发生变化时是否重新布局（视图滚动的时候也会调用）
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard scrollDirection == .vertical else{
            return true
        }
        return false
    }
    
}
extension PFColLayout {
    func doHorPopup(_ itemSize:CGSize? = CGSize(width: 0, height: 0),
                    _ scale:CGFloat = 1,
                    _ spacing: CGFloat? = 0){
        self.scrollDirection = .horizontal
        self.itemSize = itemSize!
        if  scale == 0 {
             self.scale = 1
        }else{
           self.scale = scale
        }
        self.spacing = (spacing ?? 0) * self.scale!
        self.minimumLineSpacing = spacing! * self.scale! 
        self.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func doCarousel(_ itemSize:CGSize? = CGSize(width: 0, height: 0),
                    _ isPag:Bool? = false,
                    _ miniLineSpac:CGFloat? = 0,
                    _ miniItemSpac:CGFloat? = 0,
                    _ insets: UIEdgeInsets? =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)){
        self.scrollDirection = .horizontal
        self.isPag = isPag
        self.itemSize = itemSize!
        self.minimumInteritemSpacing = miniItemSpac!
        self.minimumLineSpacing = miniLineSpac!
        self.sectionInset = insets!
    }
    
    
    func doVerticalSection(_ cols : Int? = 1,
                           _ widHeiScale:CGFloat? = 1,
                           _ heardHeight:CGFloat? = 0,
                           _ footHeight:CGFloat? = 0,
                           _ sectionHeardHeight:CGFloat? = 0,
                           _ sectionFootHeight:CGFloat? = 0,
                           _ heardFootStyle:PFFlowLayoutSectionFootHeardStyle? = .all,
                           _ miniLineSpac:CGFloat? = 0,
                           _ miniItemSpac:CGFloat? = 0,
                           _ insets: UIEdgeInsets? = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)){
        self.scrollDirection = .vertical
        self.heardHeight = heardHeight ?? 0
        self.footHeight = footHeight ?? 0
        self.sectionHeardHeight = sectionHeardHeight ?? 0
        self.sectionFootHeight = sectionFootHeight ?? 0
        if heardFootStyle == .none {
            self.heardFootStyle = PFFlowLayoutSectionFootHeardStyle.none
        }else{
            self.heardFootStyle = heardFootStyle
        }
        self.widHeiScale = widHeiScale
        self.cols = cols
        self.insets = insets
        self.sectionInset =  self.insets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.minimumLineSpacing = miniLineSpac ?? 0
        self.minimumInteritemSpacing = miniItemSpac ?? 0
        
    }
    func doWaterfallFlow(_ rowHeights:[[CGFloat]]? = [[UIScreen.main.bounds.height]],
                         _ cols : Int? = 1,
                         _ heardHeight:CGFloat? = 0,
                         _ footHeight:CGFloat? = 0,
                         _ sectionHeardHeight:CGFloat? = 0,
                         _ sectionFootHeight:CGFloat? = 0,
                         _ heardFootStyle:PFFlowLayoutSectionFootHeardStyle? = .all,
                         _ miniLineSpac:CGFloat? = 0,
                         _ miniItemSpac:CGFloat? = 0,
                         _ insets: UIEdgeInsets? = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))  {
        
        self.scrollDirection = .vertical
        self.cols = cols
        self.heardHeight = heardHeight ?? 0
        self.footHeight = footHeight ?? 0
        self.rowHeights = rowHeights
        self.sectionHeardHeight = sectionHeardHeight ?? 0
        self.sectionFootHeight = sectionFootHeight ?? 0
        if heardFootStyle == .none {
            self.heardFootStyle = PFFlowLayoutSectionFootHeardStyle.none
        }else{
            self.heardFootStyle = heardFootStyle!
        }
        self.insets = insets
        self.sectionInset =  self.insets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.minimumLineSpacing = miniLineSpac ?? 0
        self.minimumInteritemSpacing = miniItemSpac ?? 0
        
    }
}
