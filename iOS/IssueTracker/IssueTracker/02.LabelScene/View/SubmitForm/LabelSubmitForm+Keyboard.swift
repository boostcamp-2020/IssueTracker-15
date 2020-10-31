//
//  LabelSubmitForm+Keyboard.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import UIKit

extension LabelSubmitFormView {
    
    func subscribeNotifications() {
        self.subscribe(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        self.subscribe(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    }
    
    func subscribe(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        if let userInfo = notification.userInfo, let keyboardValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            
            guard formViewEndPoint == nil else { return }
            
            formViewEndPoint = self.formView.frame.origin.y + self.formView.frame.height
            let moveUpward = formViewEndPoint! - keyboardValue.origin.y
            if formViewEndPoint! > keyboardValue.origin.y {
                self.frame.origin.y -= moveUpward
            }
        }
    }
    
    @objc func formViewTapped() {
        self.endEditing(true)
        self.frame.origin.y = 0
        self.formViewEndPoint = nil
    }
}
