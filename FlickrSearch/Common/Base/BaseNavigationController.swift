//
//  BaseNavigationController.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit

class BaseNavigationController: UINavigationController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not supported")
    }
}
