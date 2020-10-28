//
//  LabelSubmitFormView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelSubmitFormView: UIView {
    
    var submitbuttonTapped: ((String, String, String) -> Void)?
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var hexCodeField: UITextField!
    @IBOutlet weak var colorView: UIView!
    private let defaultColorCode: String = "#EB7434"
    
    func configure(labelViewModel: LabelItemViewModel? = nil) {
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
    
    @IBAction func refreshColorTapped(_ sender: UIButton) {
        //        let array = ["1","2","3","4","5","6","7","8","9","A","B","C","D", "E", "F"]
        //        hexCodeLabel.text = "#".appending(array[Int(arc4random_uniform(15))])
        //                                .appending(array[Int(arc4random_uniform(15))])
        //                                .appending(array[Int(arc4random_uniform(15))])
        //        colorView.layer.backgroundColor = defaultColorCode.color
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if let titleText = titleField.text, !titleText.isEmpty,
            let descText = descField.text, !descText.isEmpty,
            let hexCodeText = hexCodeField.text, !hexCodeText.isEmpty {
            submitbuttonTapped?(titleText, descText, hexCodeText)
            self.removeFromSuperview()
        } else {
            // TODO: 사용자에게 내용을 채우라는 alert 띄워주기
        }
    }
    
    @IBAction func refreshFormButtonTapped(_ sender: UIButton) {
        titleField.text = ""
        descField.text = ""
        hexCodeField.text = defaultColorCode
        colorView.layer.backgroundColor = defaultColorCode.color
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
}

extension LabelSubmitFormView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        colorView.layer.backgroundColor = hexCodeField.text?.color
    }
}
