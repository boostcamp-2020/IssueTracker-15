//
//  UIView+ShowAlert.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension UIView {    
    func showAlert(title: String, prepare: (() -> Void)?, completion: (() -> Void)?) {
        prepare?()
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { (_: UIAlertAction) in
            completion?()
        }))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
