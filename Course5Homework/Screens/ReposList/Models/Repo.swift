//
//  Repo.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 19.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation

struct Repo: Decodable {
    
    var id: Int
    var name: String
    var description: String
    var owner: RepoOwner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.owner = try container.decode(RepoOwner.self, forKey: .owner)
    }
    
}
