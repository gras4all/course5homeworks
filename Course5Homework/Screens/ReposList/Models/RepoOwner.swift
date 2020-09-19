//
//  RepoOwner.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 19.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation

struct RepoOwner: Decodable {
    
    var id: Int
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatar_url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarUrl = try container.decode(String.self, forKey: .avatar_url)
    }
    
}
