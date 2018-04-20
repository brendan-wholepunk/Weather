import Foundation
import UIKit

class Screen : CodelessVC, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var temperature : UILabel!
    @IBOutlet weak var condition : UILabel!
    @IBOutlet weak var location : UILabel!
    @IBOutlet weak var conditionImage : UIImageView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var logo : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.tintColor = UIColor(red : 0.201924204826355, green : 0.520088374614716, blue : 1.0, alpha : 1.0)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier : "plainCell")
        self.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier : "settingCell")
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier : "contactCell")
        self.tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier : "subtitleCell")
        self.tableView.register(PersonTableViewCell.self, forCellReuseIdentifier : "personCell")
        self.tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier : "textFieldCell")
        

    }

    // MARK: Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red : 1.0, green : 0.98383754491806, blue : 0.995959401130676, alpha : 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        
        DispatchQueue.global(qos: .background).async {
            let weather : Dictionary<String, Any> = Network.getJsonDictionary(url: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22Victoria%2C%20bc%22)%20and%20u%3D'c'&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys", headers: [:])
            
            DispatchQueue.main.sync {
                
                self.temperature.text = "\(((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["item"] as? Dictionary<String, Any>)?["condition"] as? Dictionary<String, Any>)?["temp"] ?? "" )" + " ºC"
                
                self.condition.text = (((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["item"] as? Dictionary<String, Any>)?["condition"] as? Dictionary<String, Any>)?["text"] as? String != nil ? ((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["item"] as? Dictionary<String, Any>)?["condition"] as? Dictionary<String, Any>)?["text"] as! String : "")
                
                self.location.text = ("in " + "\((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["location"] as? Dictionary<String, Any>)?["city"] ?? "" )" + ", " + "\((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["location"] as? Dictionary<String, Any>)?["region"] ?? "" )" as? String != nil ? "in " + "\((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["location"] as? Dictionary<String, Any>)?["city"] ?? "" )" + ", " + "\((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["location"] as? Dictionary<String, Any>)?["region"] ?? "" )" as! String : "")
                
            }
            var quickMethodResult = Network.getImage(url: "http://l.yimg.com/a/i/us/we/52/" + "\(((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["item"] as? Dictionary<String, Any>)?["condition"] as? Dictionary<String, Any>)?["code"] ?? "" )" + ".gif", headers: [:])
            DispatchQueue.main.sync {
                
            self.conditionImage.image = quickMethodResult
            }
            let forecast = ((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["item"] as? Dictionary<String, Any>)?["forecast"] as? Array<Any> != nil ? (((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["item"] as? Dictionary<String, Any>)?["forecast"] as! Array<Any> : [])
            self.scriptVariables["forecast"] = forecast
            DispatchQueue.main.sync {
                self.tableView.reloadData()
                
            }
            var quickMethodResult1 = Network.getImage(url: ((((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["image"] as? Dictionary<String, Any>)?["url"] as? String != nil ? (((((weather as? Dictionary<String, Any>)?["query"] as? Dictionary<String, Any>)?["results"] as? Dictionary<String, Any>)?["channel"] as? Dictionary<String, Any>)?["image"] as? Dictionary<String, Any>)?["url"] as! String : ""), headers: [:])
            DispatchQueue.main.sync {
                
            self.logo.image = quickMethodResult1
            }
            
        }
        
    }

    // MARK: IBActions

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        let forecast = (self.scriptVariables["forecast"] as? Array<Any> != nil ? self.scriptVariables["forecast"] as! Array<Any> : [])
        return forecast.count
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentSection = section
        let rootHeaderView = UIView()
        let rootHeaderLabel = UILabel(frame: CGRect(x: 15.0, y: 4.0, width: 320.0, height: 21.0))
        let font : UIFont = UIFont.boldSystemFont(ofSize: 17.0)
        rootHeaderLabel.font = font
        let forecast = (self.scriptVariables["forecast"] as? Array<Any> != nil ? self.scriptVariables["forecast"] as! Array<Any> : [])
        let data = ((forecast as? Array<Any>)?[currentSection] as? Dictionary<String, Any> != nil ? (forecast as? Array<Any>)?[currentSection] as! Dictionary<String, Any> : [:])
        
        
        rootHeaderLabel.text = ("\((data as? Dictionary<String, Any>)?["day"] ?? "" )" + ", " + "\((data as? Dictionary<String, Any>)?["date"] ?? "" )" as? String != nil ? "\((data as? Dictionary<String, Any>)?["day"] ?? "" )" + ", " + "\((data as? Dictionary<String, Any>)?["date"] ?? "" )" as! String : "")
        
        rootHeaderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        rootHeaderView.addSubview(rootHeaderLabel)
        return rootHeaderView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }

    func getCellID(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> String {
        func getCellIDFromScript(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> String {
            return "settingCell"
            
        }
        var cellId = getCellIDFromScript(tableView, forRowAt: indexPath)
        if cellId != "plainCell" && cellId != "contactCell" && cellId != "settingCell" && cellId != "subtitleCell" && cellId != "personCell" && cellId != "textCell" {
            cellId = "plainCell"
        }
        return cellId
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let row = tableView.dequeueReusableCell(withIdentifier : self.getCellID(tableView, forRowAt: indexPath))!

        
        let currentSection = indexPath.section
        let forecast = (self.scriptVariables["forecast"] as? Array<Any> != nil ? self.scriptVariables["forecast"] as! Array<Any> : [])
        let data = ((forecast as? Array<Any>)?[currentSection] as? Dictionary<String, Any> != nil ? (forecast as? Array<Any>)?[currentSection] as! Dictionary<String, Any> : [:])
        
        var emoji : String = "☀️ "
        if ((data as? Dictionary<String, Any>)?["text"] as? String != nil ? (data as? Dictionary<String, Any>)?["text"] as! String : "") == "Partly Cloudy" {
            emoji = "⛅️ "
            
        }
        
        row.textLabel?.text = ("\(emoji ?? "" )" + "\((data as? Dictionary<String, Any>)?["text"] ?? "" )" as? String != nil ? "\(emoji ?? "" )" + "\((data as? Dictionary<String, Any>)?["text"] ?? "" )" as! String : "")
        
        row.detailTextLabel?.text = ("H: " + "\((data as? Dictionary<String, Any>)?["high"] ?? "" )" + " L: " + "\((data as? Dictionary<String, Any>)?["low"] ?? "" )" as? String != nil ? "H: " + "\((data as? Dictionary<String, Any>)?["high"] ?? "" )" + " L: " + "\((data as? Dictionary<String, Any>)?["low"] ?? "" )" as! String : "")
        
        row.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        

        return row
    }


    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableView.cellForRow(at: indexPath)!
        tableView.deselectRow(at: indexPath, animated: false)
    }

}