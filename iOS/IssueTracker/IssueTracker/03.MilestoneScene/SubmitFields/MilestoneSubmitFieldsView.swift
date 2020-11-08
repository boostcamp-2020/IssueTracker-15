//
//  MilestoneSubmitFields.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MilestoneSubmitFieldsView: UIStackView {
    
    enum SubmitFieldType {
        case add
        case edit(IndexPath)
    }
    
    
    @IBOutlet var dueDateLabels: [UILabel]!
    @IBOutlet weak var titleTextFieldView: UITextField!
    @IBOutlet weak var dueDateTextFieldView: UITextField!
    @IBOutlet weak var descTextFieldView: UITextField!
    
    var onSaveButtonTapped: ((String, String, String) -> Void)?
    
    func configure(milestoneItemViewModel: MilestoneSubmitFormConfigurable? = nil) {
        if let viewModel = milestoneItemViewModel {
            titleTextFieldView.text = viewModel.title
            descTextFieldView.text = viewModel.description
            dueDateTextFieldView.text = viewModel.dueDateForForm
        }
        dueDateTextFieldView.addTarget(self, action: #selector(dateFieldOnEditing), for: .editingChanged)
    }
    
}

// MARK: - Action

extension MilestoneSubmitFieldsView {
    
    @objc func dateFieldOnEditing() {
        let validate = checkDateFieldValidation()
        dueDateLabels.forEach {
            $0.textColor = validate ? .black : .red
        }
    }
    
    private func checkDateFieldValidation() -> Bool {
        guard let text = dueDateTextFieldView.text, !text.isEmpty else {
            dueDateLabels.forEach { $0.textColor = .black }
            return true
        }
        return text.contains(regexPattern: String.RegexPattern.milestoneFormDate)
    }
    
}

// MARK: - SubmitFieldProtocol Implementation

extension MilestoneSubmitFieldsView: SubmitFieldProtocol {
    
    var contentView: UIView { self }
    
    func saveButtonTapped() -> SubmitFormView.SaveResult {
        guard checkDateFieldValidation() else {
            return .failure("날짜를 양식에 맞게 적어주세요!")
        }
        
        guard let titleText = titleTextFieldView.text, !titleText.isEmpty else {
            return .failure("제목은 반드시 입력해야해요!")
        }
        
        onSaveButtonTapped?(titleText, dueDateTextFieldView?.text ?? "", descTextFieldView?.text ?? "")
        return .success
    }
    
    func resetButtonTapped() {
        titleTextFieldView.text = ""
        descTextFieldView.text = ""
        dueDateTextFieldView.text = ""
    }
    
}
