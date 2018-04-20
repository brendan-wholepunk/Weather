
import Foundation

class TableDataPlistReader {
    
    static func readTableData(fromPlist filename : String) -> [NSDictionary] {
        
        if let path = Bundle.main.path(forResource: filename, ofType: "plist") {
            return NSArray(contentsOfFile: path) as! [NSDictionary]
        } else {
            print("Table data plist not found.")
        }
        
        return []
    }
}
