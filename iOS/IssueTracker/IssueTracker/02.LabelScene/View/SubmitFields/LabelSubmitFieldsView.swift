//
//  LabelSubmitFieldsView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelSubmitFieldsView: UIStackView {
    
    enum SubmitFieldType {
        case add
        case edit(IndexPath)
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var colorView: UIView!
    private let defaultColorCode: String = "#000000"
    
    var onSaveButtonTapped: ((String, String, String) -> Void)?
    
    func configure(labelViewModel: LabelItemViewModel? = nil) {
        if let labelViewModel = labelViewModel {
            titleTextField.text = labelViewModel.title
            descTextField.text = labelViewModel.description
            colorTextField.text = labelViewModel.hexColor
        } else {
            colorTextField.text = defaultColorCode
        }
        
        colorView.layer.backgroundColor = colorTextField.text?.color
        colorTextField.addTarget(self, action: #selector(colorFieldOnEditing), for: .editingChanged)
    }
  
    private func getRandomGeneratedString() -> String {
        let letters = "ABCDEF0123456789"
        return String((1...6).map { _ in letters.randomElement()! })
    }
}

// MARK: - Action

extension LabelSubmitFieldsView {
    
    @IBAction func refreshColorButtonTapped(_ sender: Any) {
        let newHexColorCode: String = "#" + getRandomGeneratedString()
        colorTextField.text = newHexColorCode
        colorView.layer.backgroundColor = colorTextField.text?.color
    }
    
    @objc func colorFieldOnEditing() {
        colorView.layer.backgroundColor = colorTextField.text?.color
    }
    
}

// MARK: - SubmitFieldProtocol Implementation

extension LabelSubmitFieldsView: SubmitFieldProtocol {
    
    var contentView: UIView { self }
    
    func saveButtonTapped() -> SubmitFormViewController.SaveResult {
        if let titleText = titleTextField.text, !titleText.isEmpty,
            let descText = descTextField.text, !descText.isEmpty,
            let hexCodeText = colorTextField.text, !hexCodeText.isEmpty {
            onSaveButtonTapped?(titleText, descText, hexCodeText)
            return .success
        }
        
        return .failure("제목, 설명, 색상을\n모두 입력해주세요!")
    }
    
    func resetButtonTapped() {
        titleTextField.text = ""
        descTextField.text = ""
        colorTextField.text = defaultColorCode
        colorView.layer.backgroundColor = defaultColorCode.color
    }
    
}

// MARK: - Load From Nib

extension LabelSubmitFieldsView {
    
    static let labelSubmitFieldsView: String = "LabelSubmitFieldsView"
    
    static func createView() -> LabelSubmitFieldsView? {
        return Bundle.main.loadNibNamed(labelSubmitFieldsView, owner: self, options: nil)?.last as? LabelSubmitFieldsView
    }
    
}
