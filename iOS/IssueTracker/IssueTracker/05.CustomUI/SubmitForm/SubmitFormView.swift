//
//  SubmitForm.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class SubmitFormView: UIView {
    
    enum SaveResult {
        case success
        case failure(String)
    }
    
    var formViewEndPoint: CGFloat?
    var moveUpward: CGFloat = 0
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var submitFieldGuideView: UIView!
    private var submitField: SubmitFieldProtocol?
    
    func configure(submitField: SubmitFieldProtocol) {
        self.submitField = submitField
        submitFieldGuideView.addSubview(submitField.contentView)
        NSLayoutConstraint.activate([
            submitField.contentView.topAnchor.constraint(equalTo: submitFieldGuideView.topAnchor),
            submitField.contentView.bottomAnchor.constraint(equalTo: submitFieldGuideView.bottomAnchor),
            submitField.contentView.leadingAnchor.constraint(equalTo: submitFieldGuideView.leadingAnchor),
            submitField.contentView.trailingAnchor.constraint(equalTo: submitFieldGuideView.trailingAnchor)
        ])
        subscribeNotifications()
        configureTapGesture()
    }
    
}

// MARK: - Action

extension SubmitFormView {
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        removeFromSuperview()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        submitField?.resetButtonTapped()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let submitField = self.submitField else {
            removeFromSuperview()
            return
        }
        
        switch submitField.saveButtonTapped() {
        case .success:
            removeFromSuperview()
        case .failure(let message):
            showAlert(title: message, prepare: moveFormViewDownward, completion: moveFormViewUpward)
        }
        
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
    
    @objc func formViewTapped() {
        self.endEditing(true)
        self.formViewEndPoint = nil
        
        formView.frame.origin.y += moveUpward
        self.moveUpward = 0
    }
    
    @objc func backgroundTapped() {
        self.removeFromSuperview()
    }
    
}

// MARK: - Private Function

extension SubmitFormView {
    
    private func configureTapGesture() {
        formView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(formViewTapped)))
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
    }
    
    private func subscribeNotifications() {
        self.subscribe(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        self.subscribe(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    }
    
    private func subscribe(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    private func moveFormViewUpward() {
        formView.frame.origin.y -= moveUpward
    }
    
    private func moveFormViewDownward() {
        formView.frame.origin.y += moveUpward
    }
    
}
