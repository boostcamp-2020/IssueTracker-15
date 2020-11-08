//
//  IssueProvider.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol IssueProvidable: AnyObject {
    func addIssue(title: String, description: String, authorID: Int, milestoneID: Int?, completion:  @escaping (Issue?) -> Void )
    func editIssue(id: Int, description: String, completion:  @escaping (Issue?) -> Void)
    func editIssue(id: Int, title: String, completion: @escaping (Issue?) -> Void)
    func fetchIssues(completion: @escaping ([Issue]?) -> Void)
    
    func getIssue(at id: Int, completion: @escaping (Issue?) -> Void)
    func addLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func deleteLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func addMilestone(at id: Int, of milestone: Int, completion: @escaping (Issue?) -> Void)
    func deleteMilestone(at id: Int, completion: @escaping (Issue?) -> Void)
    func addAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
    func deleteAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
}

class IssueProvider: IssueProvidable {
    
    //private(set) var issues = [Issue]()
    // mock data
    // TODO: 같은 Fetch 요청이 여러번 들어왔을 겨우 completion을 배열에 넣어두었다 한 패칭에 Completion을 모두 처리해주는 방식으로!
    private var onFetching: Bool = false
    private(set) var issues: [Issue] = [ // labels 9 ~ 17 milestone 19, 22, 23, 24, 25, 28, 36
        Issue(id: 1, title: "이슈[1]", description: "ABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGHABCDEFGH", labels: [9], milestone: 19, author: "JK"),
        Issue(id: 2, title: "이슈[2]", description: "ABCDEFGH", labels: [10], milestone: 22, author: "JK"),
        Issue(id: 3, title: "이슈[3]", description: "ABCDEFGH", labels: [11], milestone: 23, author: "JK"),
        Issue(id: 4, title: "이슈[4]", description: "ABCDEFGH", labels: [12], milestone: 24, author: "JK"),
        Issue(id: 5, title: "이슈[5]", description: "ABCDEFGH", labels: [13], milestone: 25, author: "JK"),
        Issue(id: 6, title: "이슈[6]", description: "ABCDEFGH", labels: [14], milestone: 28, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK"),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK")
    ]
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
    }
    
    func fetchIssues(completion: @escaping ([Issue]?) -> Void) {
        onFetching = true

        dataLoader?.request(IssueService.fetchAll(true), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                if let datas = response.mapJsonArr() {
                    self.issues = datas.compactMap { Issue(json: $0) }
                    completion(self.issues)
                }
            }
        })

        //completion(issues)
        onFetching = false
    }
    
    /*
     Response : 201
     {
     "title": "마일스톤을 뺀 이슈 테스트!",
     "description": "마일스톤 데이터 없이 보내 봅니다...",
     "authorId": 1,
     "milestoneId": null,
     "id": 8,
     "createAt": "2020-11-08T13:21:11.702Z",
     "updateAt": "2020-11-08T13:21:11.702Z",
     "isOpened": true
     }
     */
    func addIssue(title: String, description: String, authorID: Int, milestoneID: Int?, completion: @escaping (Issue?) -> Void) {
        //createIssue (title, description, milestoneID, authorID)
        dataLoader?.request(IssueService.createIssue(title, description, milestoneID, authorID), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                if let jsonObject = response.mapJsonObject() {
                    
                }
                break
            }
        })
    }
    
    /*
     Response : 200 body: nil
     
     */
    func editIssue(id: Int, description: String, completion: @escaping (Issue?) -> Void) {
        
        dataLoader?.request(IssueService.editDescription(id, description), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                // TODO: response 처리
            break
            }
        })
        
    }
    /*
     Response : 200 body: nil
     */
    func editIssue(id: Int, title: String, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.editDescription(id, title), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
            //TODO: response 처리
            break
            }
        })
    }
    /*
     Response: 200
     {
       "id": 3,
       "title": "짜장면",
       "description": "짜장면 먹고싶네요",
       "createAt": "2020-11-02T11:42:27.161Z",
       "updateAt": "2020-11-02T11:42:27.249Z",
       "isOpened": true,
       "milestone": { /// Nil
         "id": 19,
         "title": "스프린트1"
       },
       "author": {
         "userName": "namda"
       },
       "labels": [
         {
           "id": 12,
           "title": "Configure",
           "description": "환경설정을 위한 레이블",
           "color": "#90F69E"
         }
       ],
       "assignees": [
         {
           "userName": "강근우",
           "imageURL": null
         }
       ],
       "comments": [
         {
           "id": 3,
           "content": "###안녕하세요",
           "createAt": "2020-11-02T14:26:16.241Z",
           "user": {
             "userName": "namda",
             "imageURL": ""
           }
         }
       ]
     }
     */
    func getIssue(at id: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.getIssue(id), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
            //TODO: response 처리
            break
            }
        })
    }
    /*
     response: 201 body : nil
     */
    func addLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.addLabel(id, id), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
            //TODO: response 처리
            break
            }
        })
    }
    /*
     response: 204 body: nil
     */
    func deleteLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.deleteLabel(id, id), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
            //TODO: response 처리
            break
            }
        })
    }
    
    /*
     response: 201
     */
    func addMilestone(at id: Int, of milestone: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.addMilestone(id, id), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
            //TODO: response 처리
            break
            }
        })
    }
    
    /*
     response: 204
     */
    func deleteMilestone(at id: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.deleteMilestone(id, 0), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                // TODO: response 처리
            break
            }
        })
    }
    /*
     response: 201
     */
    func addAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.addAssignee(id, userId), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                // TODO: response 처리
                break
            }
        })
    }
    /*
     response: 204
     */
    func deleteAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.deleteAssignee(id, userId), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                // TODO response 처리
                break
            }
        })
    }
        
}
