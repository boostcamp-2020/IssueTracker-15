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
    
    func configure( submitField: SubmitFieldProtocol) {
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
    
    private func configureTapGesture() {
        formView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(formViewTapped)))
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
    }
    
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
    
    @objc func formViewTapped() {
        self.endEditing(true)
        self.formViewEndPoint = nil
        
        formView.frame.origin.y += moveUpward
        self.moveUpward = 0
    }
    
    @objc func backgroundTapped() {
        self.removeFromSuperview()
    }
    
    func moveFormViewUpward() {
        formView.frame.origin.y -= moveUpward
    }
    
    func moveFormViewDownward() {
        formView.frame.origin.y += moveUpward
    }
    
}
