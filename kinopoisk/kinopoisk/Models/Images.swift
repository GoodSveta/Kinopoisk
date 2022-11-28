//
//  Images.swift
//  kinopoisk
//
//  Created by mac on 4.10.22.
//

import Foundation

// MARK: - Welcome
struct Images: Codable {
    let total, totalPages: Int
    let items: [Image]
}

// MARK: - Item
struct Image: Codable {
    let imageURL, previewURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case previewURL = "previewUrl"
    }
}
