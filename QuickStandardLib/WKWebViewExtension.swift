import Foundation
import UIKit
import WebKit

extension WKWebView {

    func loadURLFromString(_ string : String) {

        if string == "" {
            self.loadHTMLString("", baseURL: nil)
        } else {
            let url = URL(string: string)
            if url != nil {
                self.load(URLRequest(url: url!))
            } else {
                self.loadHTMLString("", baseURL: nil)
            }
        }

    }

}
