
import Foundation
import UIKit

class TableViewDataSource : NSObject, UITableViewDataSource {
    
    var sections : [NSDictionary] = []
    
    static let defaultCellReuseIdentifier = "defaultCell"
    static let plainReuseIdentifier = "plainCell"
    static let settingReuseIdentifier = "settingCell"
    static let contactReuseIdentifier = "contactCell"
    static let subtitleReuseIdentifier = "subtitleCell"
    static let textfieldReuseIdentifier = "textfieldCell"
    static let personReuseIdentifier = "personCell"

    let sectionTitleKey = "title"
    let sectionHideKey = "hide"
    let sectionRowsKey = "rows"
    let cellTypeKey = "cellTypeName"
    let cellAccessoryTypeKey = "accessoryType"
    let cellAccessoryViewKey = "accessoryView"
    let textLabelStringKey = "textLabelString"
    let detailLabelStringKey = "detailLabelString"
    let imageFilenameKey = "imageFilename"

    let cellBackgroundColor = "backgroundColor"
    let cellBackgroundColorRed = "red"
    let cellBackgroundColorGreen = "green"
    let cellBackgroundColorBlue = "blue"
    let cellBackgroundColorAlpha = "alpha"
    
    init(withData data : [NSDictionary]) {
        super.init()
        
        self.sections = data
    }
    
    // MARK: UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionDict : NSDictionary = self.sections[section]

        let hideSection = sectionDict.value(forKey: self.sectionHideKey) as! Bool
        if hideSection == true {
            return nil
        }

        let title = sectionDict.value(forKey : self.sectionTitleKey) as! String
        
        return title
    }
    
    func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        let sectionDict : NSDictionary = self.sections[section]
        let rows = sectionDict.value(forKey : self.sectionRowsKey) as! [NSDictionary]
        
        return rows.count
    }
    
    func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let sectionDict : NSDictionary = self.sections[indexPath.section]
        let rows = sectionDict.value(forKey : self.sectionRowsKey) as! [NSDictionary]
        
        let item = rows[indexPath.row]
        
        var reuseIdentifier = item.value(forKey : self.cellTypeKey) as? String
        if reuseIdentifier == nil {
            reuseIdentifier = TableViewDataSource.defaultCellReuseIdentifier
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier : reuseIdentifier!)!
        
        cell.textLabel?.text = item.value(forKey : self.textLabelStringKey) as? String
        cell.detailTextLabel?.text = item.value(forKey : self.detailLabelStringKey) as? String

        if let accessoryTypeRawValue = item.value(forKey: self.cellAccessoryTypeKey) as? Int {
            cell.accessoryType = UITableViewCellAccessoryType(rawValue: accessoryTypeRawValue)!
        }

        if let accessoryViewValue = item.value(forKey: self.cellAccessoryViewKey) as? String {
            cell.accessoryView = UINib(nibName: accessoryViewValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
            cell.accessoryView?.sizeToFit()
        }

        if let cellBackgroundColorDictionary = item.value(forKey: self.cellBackgroundColor) as? Dictionary<String, CGFloat> {

            let red = cellBackgroundColorDictionary[self.cellBackgroundColorRed]
            let green = cellBackgroundColorDictionary[self.cellBackgroundColorGreen]
            let blue = cellBackgroundColorDictionary[self.cellBackgroundColorBlue]
            let alpha = cellBackgroundColorDictionary[self.cellBackgroundColorAlpha]

            cell.backgroundColor = UIColor(red: red!, green: green!, blue: blue!, alpha: alpha!)
        }

        if let imageFilename = item.value(forKey : self.imageFilenameKey) as? String {
            if imageFilename != "" {
                cell.imageView?.image = UIImage(named : imageFilename)
            }
        }
        
        return cell
    }
}
