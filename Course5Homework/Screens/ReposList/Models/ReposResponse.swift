//
//  ReposResponse.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 19.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation

struct ReposResponse: Decodable {
    
    var count: Int
    var items: [Repo] = []
    
    enum CodingKeys: String, CodingKey {
        case total_count
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .total_count)
        self.items = try container.decode([Repo].self, forKey: .items)
    }
    
}
