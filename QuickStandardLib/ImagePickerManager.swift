
import Foundation
import UIKit

class ImagePickerManager : NSObject {
    
    var viewController : UIViewController
    var image : UIImage?
    var semaphore : DispatchSemaphore?
    
    init(withViewController vc : UIViewController) {
        self.viewController = vc
    }
    
    func getImage(sourceType type : UIImagePickerControllerSourceType) -> UIImage? {
        self.semaphore = DispatchSemaphore(value: 0)

        if Thread.isMainThread {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = type
            self.viewController.present(imagePickerController, animated: true, completion: nil)
        } else {
            DispatchQueue.main.sync {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = type
                self.viewController.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        _ = self.semaphore?.wait(timeout: .distantFuture)
        return image
    }
}

extension ImagePickerManager : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if Thread.isMainThread {
            semaphore?.signal()
            picker.dismiss(animated: true)
        } else {
            DispatchQueue.main.sync {
                semaphore?.signal()
                picker.dismiss(animated: true)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if Thread.isMainThread {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
            semaphore?.signal()
            picker.dismiss(animated: true)
        } else {
            DispatchQueue.main.sync {
                image = info[UIImagePickerControllerOriginalImage] as? UIImage
                semaphore?.signal()
                picker.dismiss(animated: true)
            }
        }
    }
}
