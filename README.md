# PFTableView-Swift
tableView和collectionView 的瘦身。将tableview以及collectionview的DataSource抽离出来。VC中代码只需很少一部分即可。

VC中大体代码：
     @IBOutlet weak var myTabView: UITableView!
     var datas  = MyTableDataSource(todos: [], owner: nil)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        datas.owner = self.myTabView
        NetStore.shared.goTabToDoItems { (d, hs, fs, h, f) in
            self.datas.reloadData(d,        <--------cell 数据
                                  heard: h, <---------头数据 可不写不显示
                                  foot: f,   <----------尾数据 可不写不显示
                                  heardInSection: hs, <------ 组头数据 可不写不显示
                                  footInSection: fs) <-------- 组尾数据 可不写不显示
        }
    }

创建DataSource

     class MyTableDataSource: PFTabDataSource {
         //可设置Cell
         override  func cellConfig(_ tableView: UITableView,_ indexPath: IndexPath, _ model : Any) -> PFTabCellConfigurable?{}
        // 可设置表头 
         override func heardView(_ tableView: UITableView,_ model : Any?) -> PFTabHeardFootConfigurable? {}
          //可设置表尾
         override func footView(_ tableView: UITableView,_ model : Any?) -> PFTabHeardFootConfigurable? {}
          //可设置组头
         override func heardInSectionConfig(_ tableView: UITableView,_ section: Int, _ model: [Any], _ maxCount : Int ) -> PFTabHeardFootConfigurable?{}
         //可设置组尾
         override func footerInSectionConfig(_ tableView: UITableView,_ section: Int, _ model: [Any], _ maxCount : Int ) -> PFTabHeardFootConfigurable?{}
         }
    
    其中cell 和 表头 组头 必须继承PFCellViewModel，并绑定对应的model
    例如：
    class OneTableViewCell: UITableViewCell ,PFCellViewModel{
      typealias ViewModel = TabOneCellModel
      var viewModel: TabOneCellModel
      func config(_ viewModel: TabOneCellModel?, complate: @escaping (Any) -> ()) {}
    }
    
   
   同时本项目中还同样有个collectionview，大体使用方式一致。详情请自行实验。若使用期间发现什么问题，记得联系我啊~~谢谢~~
   
   邮箱地址为：gpf51321@163.com
    
    
    
