//
//  String+Localized.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 10/01/21.
//

import Foundation

extension String {

    enum LocalizedKey: String {
        case homeTitle
        case searchPicturesPlaceholder
    }

    init(localized: LocalizedKey) {
        self.init(NSLocalizedString(localized.rawValue, comment: ""))
    }

    init(localized key: LocalizedKey, arguments: CVarArg...) {
        let localizedStr = String(localized: key)
        self.init(format: localizedStr, arguments: arguments.map { "\($0)" })
    }
}
