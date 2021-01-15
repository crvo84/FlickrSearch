//
//  UIViewController+Children.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 20/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Adds the given view controller as child of the receiver view controller.
    /// The child view controller's view will be added as a subview of the given container view.
    ///
    /// - Parameters:
    ///   - child: The view controller to be added as child of the receiver.
    ///   - containerView: The view on which the child's view will be added to. If `nil`, the root view will be used instead.
    ///
    /// The child's view will cover the container view completely.
    ///
    /// If the given container view is not a descendant of the parent view controller's view,
    /// calling this method won't have any effect.
    ///
    /// If the given child view controller is already a child, callid this method
    /// won't have any affect.
    func addChildViewController(_ child: UIViewController, on containerView: UIView? = nil) {
        let container = containerView ?? self.view!
        guard child.parent == nil, container.isDescendant(of: self.view) else {
            return
        }

        addChild(child)
        container.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: child.view.topAnchor),
            container.bottomAnchor.constraint(equalTo: child.view.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: child.view.trailingAnchor)
        ])

        child.didMove(toParent: self)
    }

    /// Removes the given view controller from its parent.
    /// - Parameters:
    ///   - child: The view controller to be added as child of the receiver.
    ///   If `nil`, the method will have no effect.
    ///
    /// If the given child has no parent, this method will have no effect.
    ///
    /// The child's view is also removed from its parent.
    func removeChildViewController(_ child: UIViewController?) {
        guard let child = child else { return }

        guard child.parent != nil else { return }

        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
