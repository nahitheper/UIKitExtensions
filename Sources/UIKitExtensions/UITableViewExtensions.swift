//
//  File.swift
//  
//
//  Created by Nahit Rustu Heper on 30.10.2020.
//

import UIKit

public extension UITableView {
    func dequeue<T: ViewIdentifier>(at indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(
            withIdentifier: T.identifier,
            for: indexPath
        ) as? T {
            return cell
        }
        fatalError("can not dequeue cell with identifier \(T.identifier) from tableView \(self)")
    }
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type){
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func registerHeaderOrFooter<View: UITableViewHeaderFooterView>(_ ViewClass: View.Type){
        register(ViewClass, forHeaderFooterViewReuseIdentifier: ViewClass.identifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: type))")
        }
        return headerFooterView
    }
}
