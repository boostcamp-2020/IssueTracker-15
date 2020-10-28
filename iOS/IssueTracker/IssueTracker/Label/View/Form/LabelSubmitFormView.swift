//
//  LabelSubmitFormView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelSubmitFormView: UIView {

    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var hexCodeLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func refreshColorTapped(_ sender: UIButton) {
        // TODO:- Refresh Color & HexCode
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        // TODO:- Submit Form Data
    }
    
    @IBAction func refreshFormButtonTapped(_ sender: UIButton) {
        // TODO:- Refresh whole form datas
    }
    
}
