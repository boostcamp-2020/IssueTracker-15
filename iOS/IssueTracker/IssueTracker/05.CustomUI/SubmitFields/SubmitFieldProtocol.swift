//
//  SubmitFields.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

protocol SubmitFieldProtocol {
    typealias SaveResult = (success: Bool, message: String)
    
    var contentView: UIView { get }
    func saveButtonTapped() -> SaveResult
    func resetButtonTapped()
}
