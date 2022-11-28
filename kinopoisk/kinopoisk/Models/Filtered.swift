//
//  Filtered.swift
//  kinopoisk
//
//  Created by mac on 13.04.22.
//

import Foundation

struct Filtered: Codable {
    let genres: [GenreFiltered]
    let countries: [CountryFiltered]
}

struct CountryFiltered: Codable {
    let id: Int
    let country: String
}

struct GenreFiltered: Codable {
    let id: Int
    let genre: String
}
