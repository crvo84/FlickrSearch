//
//  Theme+CornerRadius.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit

extension Theme {
    enum CornerRadius {
        case none
        case standard
        case custom(value: CGFloat)

        var value: CGFloat {
            switch self {
            case .none:
                return 0.0
            case .standard:
                return 4.0
            case let .custom(value):
                return value
            }
        }
    }
}

// MARK: - Helper extensions
extension UIView {
    func applyCornerRadius(_ cornerRadius: Theme.CornerRadius) {
        layer.cornerRadius = max(0, cornerRadius.value)
        layer.masksToBounds = cornerRadius.value > 0
    }
}
