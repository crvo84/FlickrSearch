//
//  UIViewController+Navigation.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit

extension UIViewController {

    /// Dismisses the presented view controller.
    /// If there is no presented view controller, calls the completion block inmediately.
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition if needed. Defaults to `true`.
    ///   - completion: The block to execute after the view controller is dismissed.
    ///   This block has no return value and takes no parameters.
    ///   You may specify nil for this parameter.
    func dismissPresentedViewControllerIfNeeded(animated: Bool = true, completion: (() -> Void)?) {
        guard presentedViewController != nil else {
            completion?()
            return
        }

        dismiss(animated: true, completion: completion)
    }
}
