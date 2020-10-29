//
//  UIView+ShowAlert.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension UIView {
    func showAlert(title: String) {
        let previousFrameOrigin = self.frame.origin.y
        self.frame.origin.y = 0
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { [weak self] (_: UIAlertAction) in
            self?.frame.origin.y = previousFrameOrigin
        }))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
