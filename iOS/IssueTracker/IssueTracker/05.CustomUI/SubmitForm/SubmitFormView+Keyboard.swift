//
//  SubmitFormView+Keyboard.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension SubmitFormView {
    
    func subscribeNotifications() {
        self.subscribe(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        self.subscribe(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    }
    
    func subscribe(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let keyboardValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            
            guard formViewEndPoint == nil else { return }
            
            let newEndPoint = self.formView.frame.origin.y + self.formView.frame.height
            formViewEndPoint = newEndPoint
            
            moveUpward = newEndPoint - keyboardValue.origin.y
            if newEndPoint > keyboardValue.origin.y {
                formView.frame.origin.y -= moveUpward
            }
        }
    }
    
}
