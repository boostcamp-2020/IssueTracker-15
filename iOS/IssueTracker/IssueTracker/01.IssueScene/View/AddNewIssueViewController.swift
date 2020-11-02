//
//  AddNewIssueViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class AddNewIssueViewController: UIViewController {
    static let identifier = "AddNewIssueViewController"
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    private let textViewPlaceholder = "코멘트는 여기에 작성하세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새 이슈"
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        self.subscribe(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
        self.subscribe(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        
        configureCommentTextView()
    }
    
    private func subscribe(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func configureCommentTextView() {
        commentTextView.delegate = self
        commentTextView.text = textViewPlaceholder
        commentTextView.textColor = .lightGray
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // 저장 후 dismiss
    }
    
    private func setupTextView() {
        if commentTextView.text == textViewPlaceholder {
            commentTextView.text = ""
            commentTextView.textColor = .black
        } else if commentTextView.text.isEmpty {
            commentTextView.text = textViewPlaceholder
            commentTextView.textColor = .lightGray
        }
    }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let keyboardValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            
            if notification.name == UIResponder.keyboardWillHideNotification {
                commentTextView.contentInset = UIEdgeInsets.zero
            } else {
                commentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardValue.height, right: 0)
                commentTextView.scrollIndicatorInsets = commentTextView.contentInset
            }
            
            commentTextView.scrollRangeToVisible(commentTextView.selectedRange)
        }
    }
}

extension AddNewIssueViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setupTextView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text.isEmpty {
            setupTextView()
        }
    }
}
