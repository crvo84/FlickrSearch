//
//  Array+Extensions.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 12/01/21.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
