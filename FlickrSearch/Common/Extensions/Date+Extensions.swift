//
//  Date+Extensions.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 12/01/21.
//

import Foundation

extension Date {

    func get(component: Calendar.Component,
             calendar: Calendar = .current) -> Int {
        calendar.component(component, from: self)
    }
}
