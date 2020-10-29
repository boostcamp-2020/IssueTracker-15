//
//  LabelSubmitFormView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelSubmitFormView: UIView {
    var formViewEndPoint: CGFloat?
    var submitbuttonTapped: ((String, String, String) -> Void)?
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var hexCodeField: UITextField!
    @IBOutlet weak var colorView: UIView!
    private let defaultColorCode: String = "#000000"
    
    func configure(labelViewModel: LabelItemViewModel? = nil) {
        configureTapGesture()
        subscribeNotifications()
        
        hexCodeField.delegate = self
        
        if let labelViewModel = labelViewModel {
            titleField.text = labelViewModel.title
            descField.text = labelViewModel.description
            hexCodeField.text = labelViewModel.hexColor
        } else {
            hexCodeField.text = defaultColorCode
        }
        
        colorView.layer.backgroundColor = hexCodeField.text?.color
    }
    
    private func configureTapGesture() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
    }
    
    @IBAction func refreshColorTapped(_ sender: UIButton) {
        let newHexColorCode: String = "#" + getRandomGeneratedString()
        hexCodeField.text = newHexColorCode
        colorView.layer.backgroundColor = hexCodeField.text?.color
    }
    
    private func getRandomGeneratedString() -> String {
        let letters = "ABCDEF0123456789"
        return String((1...6).map { _ in letters.randomElement()! })
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let titleText = titleField.text, !titleText.isEmpty,
            let descText = descField.text, !descText.isEmpty,
            let hexCodeText = hexCodeField.text, !hexCodeText.isEmpty {
            submitbuttonTapped?(titleText, descText, hexCodeText)
            self.removeFromSuperview()
        } else {
            self.showAlert(title: "제목, 설명, 색상을\n모두 입력해주세요!")
        }
    }
    
    @IBAction func resetFormButtonTapped(_ sender: UIButton) {
        titleField.text = ""
        descField.text = ""
        hexCodeField.text = defaultColorCode
        colorView.layer.backgroundColor = defaultColorCode.color
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @objc func backgroundTapped() {
        self.removeFromSuperview()
    }
}

extension LabelSubmitFormView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        colorView.layer.backgroundColor = hexCodeField.text?.color
    }
}
