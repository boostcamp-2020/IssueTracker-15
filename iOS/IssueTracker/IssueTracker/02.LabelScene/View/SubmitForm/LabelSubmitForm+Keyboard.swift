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
            
            let newEndPoint = self.formView.frame.origin.y + self.formView.frame.height
            formViewEndPoint = newEndPoint
            
            moveUpward = newEndPoint - keyboardValue.origin.y
            if newEndPoint > keyboardValue.origin.y {
                formView.frame.origin.y -= moveUpward
            }
        }
    }
    
    @objc func formViewTapped() {
        self.endEditing(true)
        self.formViewEndPoint = nil
        
        formView.frame.origin.y += moveUpward
        self.moveUpward = 0
    }
}
