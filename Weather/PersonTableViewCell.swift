
import UIKit

class PersonTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // image view size and shape

        self.imageView?.frame.size.width = self.contentView.frame.size.height
        self.imageView?.frame = CGRect(x: (self.imageView?.frame.origin.x)! + 8, y: (self.imageView?.frame.origin.y)! + 8, width: (self.imageView?.frame.size.width)! - 16, height: (self.imageView?.frame.size.height)! - 16)
        self.imageView?.layer.cornerRadius = self.imageView?.frame.size.width != nil ? (self.imageView?.frame.size.width)! / 2 : 0
        self.imageView?.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFill

        // text and detail text labels positioning

        let newXPosition = (self.imageView?.frame.origin.x)! + (self.imageView?.frame.size.width)! + 12.0

        let newWidth = self.contentView.frame.size.width - newXPosition

        self.textLabel?.frame = CGRect(x: newXPosition, y: (self.textLabel?.frame.origin.y)!, width: newWidth, height: (self.textLabel?.frame.size.height)!)
        self.detailTextLabel?.frame = CGRect(x: newXPosition, y: (self.detailTextLabel?.frame.origin.y)!, width: newWidth, height: (self.detailTextLabel?.frame.size.height)!)

        // separator size

        for var subview : UIView in self.subviews {
            // detecting the separator via hacky, ios 4-style ways
            if subview.frame.size.height == 0.5 {
                subview.frame = CGRect(x: 15.0, y: subview.frame.origin.y, width: self.contentView.frame.size.width - 15.0, height: subview.frame.size.height)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
