//
//  UITableView+.swift
//  PeopleCase
//
//  Created by Mert on 10.08.2021.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? cellType.reuseIdentifier
        
        if cellType == UITableViewCell.self {
            self.register(cellType.classForCoder(), forCellReuseIdentifier: identifier)
        } else {
            self.register(cellType.nib, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self, reuseIdentifier: String? = nil) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier ?? cellType.reuseIdentifier, for: indexPath) as! T
        return cell
    }
    
    func setEmptyMessage(_ message: String) {
           let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
           messageLabel.text = message
           messageLabel.textColor = .lightGray
           messageLabel.numberOfLines = 0
           messageLabel.textAlignment = .center
           messageLabel.font = UIFont(name: "Helvetica Neue", size: 16)
           messageLabel.sizeToFit()

           self.backgroundView = messageLabel
           self.separatorStyle = .none
       }

       func restore() {
           self.backgroundView = nil
           self.separatorStyle = .singleLine
       }
}

extension UITableViewCell: Reusable {

}
