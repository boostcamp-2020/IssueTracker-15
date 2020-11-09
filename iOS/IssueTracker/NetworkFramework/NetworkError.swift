//
//  NetworkError.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case endPointMaappingError(String)
    case urlMappingError(String)
    case encodingData(Error)
    case responseError(String)
    case underlying(Error, Response?)
}
