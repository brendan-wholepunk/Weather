
import Foundation
import UIKit

extension Dictionary {
    mutating func add(dictionary : Dictionary) {
        for (key,value) in dictionary {
            self.updateValue(value, forKey:key)
        }
    }
}

extension Dictionary where Key == String, Value == Any {
    static func add(item value : Any, withKey key : String, toDictionary dict : [String : Any]) -> [String : Any] {
        var result = dict
        result[key] = value
        return result
    }
    
    static func remove(key: String, fromDictionary dict : [String : Any]) -> [String : Any] {
        var result = dict
        result[key] = nil
        return result
    }

    static func compare(_ dictionary1 : [String : Any ], with dictionary2 : [ String : Any ]) -> Bool {

        if dictionary1.keys.count != dictionary2.keys.count {
            return false
        }

        var result = true
        var index = 0
        for key in dictionary1.keys {
            let element = dictionary1[key]
            let compareElement = dictionary2[key]
            if element is Int && compareElement is Int {
                result = (element as! Int) == (compareElement as! Int)
            } else if element is Float && compareElement is Float {
                result = (element as! Float) == (compareElement as! Float)
            } else if element is String && compareElement is String {
                result = (element as! String) == (compareElement as! String)
            } else if element is Bool && compareElement is Bool {
                result = (element as! Bool) == (compareElement as! Bool)
            } else if element is UIColor && compareElement is UIColor {
                result = (element as! UIColor) == (compareElement as! UIColor)
            } else {
                result = false
            }
            index = index + 1
        }

        return result

    }

}
