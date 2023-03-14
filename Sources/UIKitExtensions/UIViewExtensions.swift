//
//  File.swift
//  
//
//  Created by Nahit Rustu Heper on 30.10.2020.
//

import Foundation
import UIKit

public protocol ViewIdentifier: AnyObject {
    static var identifier: String { get }
}

public extension ViewIdentifier {
    static var identifier: String {
        String(describing: self)
    }
}

extension UIView: ViewIdentifier {}


public extension UIView {
    
    private struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    private typealias Action = (() -> Void)?
    
    private var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    func addTapGestureRecognizer(action: (() -> Void)?) {
        isUserInteractionEnabled = true
        tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    func applySketchShadow(color: UIColor = .black,
                           alpha: Float = 0.2,
                           x: CGFloat = 0,
                           y: CGFloat = 2,
                           blur: CGFloat = 4,
                           spread: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2
        guard spread != 0 else {
            layer.shadowPath = nil
            return
        }
        let dx = -spread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        layer.shadowPath = UIBezierPath(rect: rect).cgPath
    }
    
    func makeCornersRounded(_ radius: CGFloat, corners: CACornerMask) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    func makeTopCornersRounded(_ radius: CGFloat) {
        makeCornersRounded(radius, corners: CALayer.topCorners)
    }
    
    func makeBottomCornersRounded(_ radius: CGFloat) {
        makeCornersRounded(radius, corners: CALayer.bottomCorners)
    }
    
    func makeLeftCornersRounded(_ radius: CGFloat) {
        makeCornersRounded(radius, corners: CALayer.leftCorners)
    }
    
    func makeRightCornersRounded(_ radius: CGFloat) {
        makeCornersRounded(radius, corners: CALayer.rightCorners)
    }
}

private extension CALayer {
    static var allCorners: CACornerMask {
        return [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
            .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
    }
    
    static var topCorners: CACornerMask {
        return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    static var bottomCorners: CACornerMask {
        return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    static var leftCorners: CACornerMask {
        return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    static var rightCorners: CACornerMask {
        return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
}
