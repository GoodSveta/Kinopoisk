//
//  PremierFilms.swift
//  kinopoisk
//
//  Created by mac on 11.04.22.
//

import Foundation

// MARK: - Premiers
struct Premiers: Codable {
    let total: Int
    let films: [PremierFilm]
    
    enum CodingKeys: String, CodingKey {
        case films = "items"
        case total
    }
}

// MARK: - Item
struct PremierFilm: Codable {
    let kinopoiskID: Int
    let nameRu, nameEn: String
    let year: Int
    let posterURL, posterURLPreview: String
    let countries: [Country]
    let genres: [Genre]
    let duration: Int?
    let premiereRu: String

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case nameRu, nameEn, year
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
        case countries, genres, duration, premiereRu
    }
}
