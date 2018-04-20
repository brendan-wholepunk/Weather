
import Foundation
import UIKit

extension UIAlertController {
    
    static func show(alertControllerInViewController vc : UIViewController, title : String, message : String, actions : [String]) -> String {
        var result = ""
        let alertSemaphore = DispatchSemaphore(value: 0)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(UIAlertAction(title: action, style: .default, handler: { (action) in
                result = action.title!
                alertSemaphore.signal()
            }))
        }
        DispatchQueue.main.sync {
            vc.present(alertController, animated: true, completion: nil)
        }
        alertSemaphore.wait()
        return result
    }
    
    static func show(actionSheetInViewController vc : UIViewController, title : String, message : String, actions : [String]) -> String {
        var result = ""
        let alertSemaphore = DispatchSemaphore(value: 0)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            alertController.addAction(UIAlertAction(title: action, style: .default, handler: { (action) in
                result = action.title!
                alertSemaphore.signal()
            }))
        }
        
        DispatchQueue.main.sync {
            vc.present(alertController, animated: true, completion: nil)
        }
        alertSemaphore.wait()
        return result
    }
}
