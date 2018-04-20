
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var scriptVariables: Dictionary<String, Any> = Dictionary()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    static func quickSave(string: String, toFile path: String) -> Bool {
        let documentsUrl : URL = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask)[0]
        let documentPath = documentsUrl.appendingPathComponent(path)
        do {
            try string.write(to: documentPath, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
    
    static func quickSave(array: Array<Any>, toFile path: String) -> Bool {
        let documentsUrl : URL = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask)[0]
        let documentPath = documentsUrl.appendingPathComponent(path)
        do {
            try (array as NSArray).write(to: documentPath)
            return true
        } catch {
            return false
        }
    }
    
    static func quickSave(dict: Dictionary<String, Any>, toFile path: String) -> Bool {
        let documentsUrl : URL = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask)[0]
        let documentPath = documentsUrl.appendingPathComponent(path)
        do {
            try (dict as NSDictionary).write(to: documentPath)
            return true
        } catch {
            return false
        }
    }
    
    static func quickLoad(stringFromFile path: String) -> String {
        let documentsUrl : URL = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask)[0]
        let documentPath = documentsUrl.appendingPathComponent(path)
        do {
            return try NSString(contentsOf: documentPath, encoding: String.Encoding.utf8.rawValue) as String
        } catch {
            return ""
        }
    }
    
    static func quickLoad(arrayFromFile path: String) -> Array<Any> {
        let documentsUrl : URL = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask)[0]
        let documentPath = documentsUrl.appendingPathComponent(path)
        if let array = NSArray(contentsOf: documentPath) as? Array<Any> {
            return array
        } else {
            return []
        }
    }
    
    static func quickLoad(dictFromFile path: String) -> Dictionary<String, Any> {
        let documentsUrl : URL = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask)[0]
        let documentPath = documentsUrl.appendingPathComponent(path)
        if let dict = NSDictionary(contentsOf: documentPath) as? Dictionary<String, Any> {
            return dict
        } else {
            return [:]
        }
    }

}
