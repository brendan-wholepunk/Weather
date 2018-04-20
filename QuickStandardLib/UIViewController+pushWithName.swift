
import UIKit

class CodelessVC : UIViewController {
    var scriptVariables : [String : Any] = [:]
}

extension UIViewController {

    func push(withName name : String, context: [String: Any] = [:]) {
        let name = name.replacingOccurrences(of: " ", with: "")
        let vc = self.storyboard!.instantiateViewController(withIdentifier: name)
        (vc as? CodelessVC)?.scriptVariables = context
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
