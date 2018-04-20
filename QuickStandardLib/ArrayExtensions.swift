
import Foundation
import UIKit

extension Array where Element == Any {
    static func add(item : Any, toArray array : Array<Any>) -> Array<Any> {
        var result = array
        result.append(item)
        return result
    }
    
    static func remove(index : Int, fromArray array : Array<Any>) -> Array<Any> {
        var result = array
        result.remove(at: index)
        return result
    }
    
    static func replace(index : Int, withValue value : Any, inArray array : Array<Any>) -> Array<Any> {
        var result = array
        result[index] = value
        return result
    }
    
    static func compare(_ arrayOne : Array<Any>, with arrayTwo : Array<Any>) -> Bool {
        
        if arrayOne.count != arrayTwo.count {
            return false
        }
        
        var result = true
        var index = 0
        for element in arrayOne {
            let compareElement = arrayTwo[index]
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
    
    static func sort(_ array : Array<Any>) -> Array<Any> {
        var less : Array<Any> = Array()
        var equal : Array<Any> = Array()
        var greater : Array<Any> = Array()
        
        if array.count > 1 {
            let pivot = array[0]
            
            for val in array {
                let comp = Array.compare(val, pivot)
                if comp < 0 {
                    less.append(val)
                }
                if comp == 0 {
                    equal.append(val)
                }
                if comp > 0 {
                    greater.append(val)
                }
            }
            
            return (Array.sort(less) + equal + Array.sort(greater))
        }
        
        return array
    }
    
    static func compare(_ value1 : Any, _ value2 : Any) -> Int {
        if Array.typeValue(value1) > Array.typeValue(value2) {
            return 1
        }
        if Array.typeValue(value1) < Array.typeValue(value2) {
            return -1
        }
        if Array.typeValue(value1) == Array.typeValue(value2) {
            switch value1 {
            case is Bool:
                if (value1 as! Bool)  == true && (value2 as! Bool) == false {
                    return 1
                }
                if (value1 as! Bool)  == false && (value2 as! Bool) == true {
                    return -1
                }
                if (value1 as! Bool) == (value2 as! Bool) {
                    return 0
                }
            case is Int:
                if (value1 as! Int) > (value2 as! Int) {
                    return 1
                }
                if (value1 as! Int) < (value2 as! Int) {
                    return -1
                }
                if (value1 as! Int) == (value2 as! Int) {
                    return 0
                }
            case is CGFloat:
                if (value1 as! CGFloat) > (value2 as! CGFloat) {
                    return 1
                }
                if (value1 as! CGFloat) < (value2 as! CGFloat) {
                    return -1
                }
                if (value1 as! CGFloat) == (value2 as! CGFloat) {
                    return 0
                }
            case is String:
                if (value1 as! String) > (value2 as! String) {
                    return 1
                }
                if (value1 as! String) < (value2 as! String) {
                    return -1
                }
                if (value1 as! String) == (value2 as! String) {
                    return 0
                }
            case is UIColor:
                return 0
            case is Array<Any>:
                if (value1 as! Array<Any>).count > (value2 as! Array<Any>).count {
                    return 1
                }
                if (value1 as! Array<Any>).count < (value2 as! Array<Any>).count {
                    return -1
                }
                if (value1 as! Array<Any>).count == (value2 as! Array<Any>).count {
                    return 0
                }
            case is Dictionary<String, Any>:
                if (value1 as! Dictionary<String, Any>).keys.count > (value2 as! Dictionary<String, Any>).keys.count {
                    return 1
                }
                if (value1 as! Dictionary<String, Any>).keys.count < (value2 as! Dictionary<String, Any>).keys.count {
                    return -1
                }
                if (value1 as! Dictionary<String, Any>).keys.count == (value2 as! Dictionary<String, Any>).keys.count {
                    return 0
                }
            default:
                return 0
            }
        }
        
        return 0
    }
    
    static func typeValue(_ value : Any) -> Int {
        switch value {
        case is Bool:
            return 0
        case is Int:
            return 1
        case is CGFloat:
            return 2
        case is String:
            return 3
        case is UIColor:
            return 4
        case is Array<Any>:
            return 5
        case is Dictionary<String, Any>:
            return 6
        default:
            return 0
        }
    }
}
