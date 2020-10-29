//
//  MilestoneSubmitFormView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MilestoneSubmitFormView: UIView {
    var formViewEndPoint: CGFloat?
    var submitbuttonTapped: ((String, String, String) -> Void)?
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    func configure(milestoneItemViewModel: MilestoneSubmitFormConfigurable? = nil) {
        configureTapGesture()
        subscribeNotifications()
        
        if let viewModel = milestoneItemViewModel {
            titleField.text = viewModel.title
            descField.text = viewModel.description
            dateField.text = viewModel.dueDateForForm
        }
        
        dateField.addTarget(self, action: #selector(dateFieldOnEditing), for: .editingChanged)
    }
    
    private func configureTapGesture() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard checkDateFieldValidation() else {
            showAlert(title: "날짜를 양식에 맞게 적어주세요!")
            return
        }
        
        guard let titleText = titleField.text, !titleText.isEmpty else {
            showAlert(title: "제목은 반드시 입력해야해요!")
            return
        }
        
        submitbuttonTapped?(titleText, descField?.text ?? "", dateField?.text ?? "")
        self.removeFromSuperview()
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        titleField.text = ""
        descField.text = ""
        dateField.text = ""
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @objc func backgroundTapped() {
        self.removeFromSuperview()
    }
    
    @objc func dateFieldOnEditing() {
        dateLabel.textColor = checkDateFieldValidation() ? .black : .red
    }
    
    private func checkDateFieldValidation() -> Bool {
        guard let text = dateField.text, !text.isEmpty else {
            dateLabel.textColor = .black
            return true
        }
        return text.contains(of: String.RegexPattern.milestoneFormDate)
    }
}
