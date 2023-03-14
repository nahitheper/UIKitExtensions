//
//  UIControlExtensions.swift
//  
//
//  Created by Nahit Rustu Heper on 15.03.2023.
//

import UIKit
public extension UIControl {
    func addTapAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        let sleeve = ActionClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ActionClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
private class ActionClosureSleeve {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke () {
        closure()
    }
}
