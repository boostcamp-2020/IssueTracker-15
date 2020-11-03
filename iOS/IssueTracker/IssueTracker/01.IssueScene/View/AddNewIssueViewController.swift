//
//  AddNewIssueViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class AddNewIssueViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    private var previewLabelView = UITextView()
    private var commentTextView: UITextView = UITextView()
    @IBOutlet weak var commonView: UIView!
    
    private let textViewPlaceholder = "코멘트는 여기에 작성하세요"
    var doneButtonTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새 이슈"
        
        configureKeyboardRelated()
        configureNavigationBar()
        configurePreviewLabelView()
        configureCommentTextView()
    }
    
    private func configureKeyboardRelated() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        self.subscribe(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
        self.subscribe(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
    }
    
    private func subscribe(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func configureNavigationBar() {
        let commonAppearance = UINavigationBarAppearance()
        commonAppearance.backgroundColor = .white
        commonAppearance.shadowColor = .gray
        self.navigationController?.navigationBar.scrollEdgeAppearance = commonAppearance
    }
    
    private func configureCommentTextView() {
        commentTextView.delegate = self
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commonView.addSubview(commentTextView)
        commentTextView.leadingAnchor.constraint(equalTo: commonView.leadingAnchor).isActive = true
        commentTextView.topAnchor.constraint(equalTo: commonView.topAnchor).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: commonView.trailingAnchor).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: commonView.bottomAnchor).isActive = true
        initTextViewPlaceholder()
    }
    
    private func configurePreviewLabelView() {
        previewLabelView.backgroundColor = .red
        previewLabelView.translatesAutoresizingMaskIntoConstraints = false
        commonView.addSubview(previewLabelView)
        previewLabelView.leadingAnchor.constraint(equalTo: commonView.leadingAnchor).isActive = true
        previewLabelView.topAnchor.constraint(equalTo: commonView.topAnchor).isActive = true
        previewLabelView.trailingAnchor.constraint(equalTo: commonView.trailingAnchor).isActive = true
        previewLabelView.bottomAnchor.constraint(equalTo: commonView.bottomAnchor).isActive = true
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        /*
         doneButtonTapped()
         서버와 통신, POST 요청
         응답이 오면 (OK status code, 서버 저장에 성공한 객체)
         해당 객체를 decode 하여 프론트 collectionview의 datasource에도 추가
         datasource는 이슈목록 리스트에 있으므로 doneButtonTapped를 주입시키든가 delegate protocol을 통해서 datasource를 건드릴 수 있도록 수정
         
         dismiss()
         현재 VC를 dismiss한다.
        */
        
        doneButtonTapped?()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initTextViewPlaceholder() {
        // 마크다운 작성 View를 configure 할 때
        if commentTextView.text.isEmpty {
            commentTextView.text = textViewPlaceholder
            commentTextView.textColor = .lightGray
        }
    }
    
    private func setTextViewPlaceholder() {
        // 마크다운 작성 View를 begin/end editing 할 때
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
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("마크다운")
            previewLabelView.removeFromSuperview()
            commonView.addSubview(commentTextView)
            configureCommentTextView()
        case 1:
            print("미리보기")
            commentTextView.removeFromSuperview()
            commonView.addSubview(previewLabelView)
            configurePreviewLabelView()
        default:
            return
        }
    }
    
}

extension AddNewIssueViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextViewPlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text.isEmpty {
            setTextViewPlaceholder()
        }
    }
}
