//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Андрей Фокин on 28.10.21.
//

import Foundation

struct PhotoInfo: Codable {
    let title: String
    let description: String
    let url: URL
    let copyright: String?
    
    enum CodingKeys: String, CodingKey{
        case title
        case description = "explanation"
        case url
        case copyright
    }
}
