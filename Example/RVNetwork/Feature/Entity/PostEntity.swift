//
//  PostEntity.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 22/01/23.
//  Copyright © 2022 r.ranjanchn@gmail.com. All rights reserved.
//

import Foundation

// MARK: - PostElement
struct PostElement: Codable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Post = [PostElement]
