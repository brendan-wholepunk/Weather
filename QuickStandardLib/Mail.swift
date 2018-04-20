
import Foundation
import MessageUI

class Mail {
    
    static let emailSemaphore = DispatchSemaphore(value: 0)
    static var result = false
    
    static func sendEmail(toAddress address : String, subjectLine subject : String, emailBody body : String, presentInViewController vc : UIViewController) -> Bool {
        if !MFMailComposeViewController.canSendMail() {
            print("ERROR: Mail services are not available")
            return false
        }
        
        let delegate = MailDelegate()
        Mail.result = false
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = delegate
        composeVC.setToRecipients([address])
        composeVC.setSubject(subject)
        composeVC.setMessageBody(body, isHTML: false)
        
        DispatchQueue.main.async {
            vc.present(composeVC, animated: true, completion: nil)
        }
        
        Mail.emailSemaphore.wait()
        
        return Mail.result
    }
}

class MailDelegate : NSObject, MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        Mail.emailSemaphore.signal()
        controller.dismiss(animated: true, completion: nil)
    }
}
