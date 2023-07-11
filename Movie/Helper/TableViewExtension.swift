//
//  TableViewExtension.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
}
