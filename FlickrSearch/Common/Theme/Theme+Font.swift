//
//  Theme+Font.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit

extension Theme {
    enum Font {
        case largeTitle
        case title
        case headline
        case body
        case caption
        case navigationBar
    }
}

extension Theme.Font {

    var uiFont: UIFont {
        var uiFont: UIFont
        switch self {
        case .largeTitle, .title, .headline:
            uiFont = .boldSystemFont(ofSize: self.size)
        case .body, .caption, .navigationBar:
            uiFont = .systemFont(ofSize: self.size)
        }

        return uiFont
    }
}

// MARK: - Font Sizes
extension Theme.Font {

    var size: CGFloat {
        switch self {
        case .largeTitle:
            return 34
        case .title:
            return 28
        case .headline:
            return 22
        case .body:
            return 17
        case .caption:
            return 12
        case .navigationBar:
            return 18
        }
    }
}

// MARK: - Helper extensions
extension UILabel {

    func applyTheme(font: Theme.Font, color: Theme.Color) {
        self.font = font.uiFont
        self.textColor = color.uiColor
    }
}
