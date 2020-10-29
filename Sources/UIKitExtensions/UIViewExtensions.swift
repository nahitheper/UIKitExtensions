//
//  File.swift
//  
//
//  Created by Nahit Rustu Heper on 30.10.2020.
//

import Foundation
import UIKit

public protocol ViewIdentifier: class {
    static var identifier: String { get }
}

public extension ViewIdentifier {
    static var identifier: String {
        String(describing: self)
    }
}

extension UIView: ViewIdentifier {}
