//
//  Reusable.swift
//  PeopleCase
//
//  Created by Mert on 10.08.2021.
//

import Foundation
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

protocol NibProviable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension NibProviable {
    static var nibName: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}

typealias Reusable = ReusableView & NibProviable
