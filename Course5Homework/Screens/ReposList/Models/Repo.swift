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
    
}
