//
//  SubmitFields.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

protocol SubmitFieldProtocol {
    var contentView: UIView { get }
    func saveButtonTapped() -> SubmitFormViewController.SaveResult
    func resetButtonTapped()
}
