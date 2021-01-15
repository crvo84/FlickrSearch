//
//  UIView+Constraints.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 10/01/21.
//

import UIKit

extension UIView {

    func constraintToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: +insets.top),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: +insets.left),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }
}

