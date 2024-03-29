//
//  File.swift
//  
//
//  Created by Nahit Rustu Heper on 30.10.2020.
//

import UIKit
public extension UICollectionView {
    func dequeue<T: ViewIdentifier>(at indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(
            withReuseIdentifier: T.identifier,
            for: indexPath
        ) as? T {
            return cell
        }
        fatalError("can not dequeue cell with identifier \(T.identifier) from tableView \(self)")
    }
}
