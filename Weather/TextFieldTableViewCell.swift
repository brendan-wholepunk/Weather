
import UIKit

class TextFieldTableViewCell: UITableViewCell {

    var detailTextField : UITextField?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textLabel?.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addConstraint(NSLayoutConstraint(item: self.textLabel as Any, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 15.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.textLabel as Any, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.textLabel as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0))

        detailTextField = UITextField()
        detailTextField?.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(detailTextField!)

        self.contentView.addConstraint(NSLayoutConstraint(item: detailTextField as Any, attribute: .leading, relatedBy: .equal, toItem: self.textLabel, attribute: .trailing, multiplier: 1.0, constant: 12.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: detailTextField as Any, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -8.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: detailTextField as Any, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: detailTextField as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
