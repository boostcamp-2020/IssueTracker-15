//
//  Label.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct Label: Codable {
    let id: Int
    let title: String
    let description: String
    let hexColor: String
    
    init(id: Int, title: String, description: String, hexColor: String) {
        self.id = id
        self.title = title
        self.description = description
        self.hexColor = hexColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DeCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        hexColor = try container.decode(String.self, forKey: .hexColor)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnCodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(hexColor, forKey: .hexColor)
    }
    
    enum EnCodingKeys: String, CodingKey {
        case title = "name"
        case description
        case hexColor = "color"
    }
    
    enum DeCodingKeys: String, CodingKey {
        case id
        case title = "name"
        case description
        case hexColor = "color"
    }
}
