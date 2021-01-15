//
//  Theme+NavigationBar.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 10/01/21.
//

import UIKit

extension Theme {
    enum NavBar {
        case main
    }
}

extension Theme.NavBar {
    var backgroundColor: Theme.Color {
        .darkTint
    }

    var tintColor: Theme.Color {
        .mainTint
    }

    var isTranslucent: Bool {
        false
    }

    var titleTextColor: Theme.Color {
        .mainTint
    }

    var titleFont: Theme.Font? {
        nil
    }
}

// MARK: - Helper extensions
extension UINavigationController {

    func applyThemeNavBar(_ themeNavBar: Theme.NavBar) {
        navigationBar.barTintColor = themeNavBar.backgroundColor.uiColor
        navigationBar.tintColor = themeNavBar.tintColor.uiColor
        navigationBar.isTranslucent = themeNavBar.isTranslucent

        var titleAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: themeNavBar.titleTextColor.uiColor
        ]
        if let titleFont = themeNavBar.titleFont {
            titleAttrs[.font] = titleFont.uiFont
        }
        navigationBar.titleTextAttributes = titleAttrs
    }
}
