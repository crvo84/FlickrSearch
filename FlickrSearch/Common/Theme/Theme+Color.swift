//
//  Theme+Color.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit

extension Theme {
    enum Color {
        case mainTint
        case darkTint
        case mainBackground
        case primaryLabel
        case secondaryLabel
        case lightLabel
    }
}

// MARK: - UIColor
extension Theme.Color {

    var uiColor: UIColor {
        switch self {
        case .mainTint:
            return UIColor(red: 0.5, green: 0.75, blue: 1.0, alpha: 1.0)
        case .darkTint:
            return UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 1.0)
        case .mainBackground:
            return .systemBackground
        case .primaryLabel:
            return .label
        case .secondaryLabel:
            return .secondaryLabel
        case .lightLabel:
            return .white
        }
    }
}

// MARK: - Helper extensions
extension UIView {

    func applyTheme(bgColor: Theme.Color) {
        self.backgroundColor = bgColor.uiColor
    }
}
