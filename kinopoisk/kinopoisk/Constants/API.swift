//
//  API.swift
//  kinopoisk
//
//  Created by mac on 16.03.22.
//



import Foundation

enum TopFilmsType: String {
    case TOP_250_BEST_FILMS, TOP_100_POPULAR_FILMS, TOP_AWAIT_FILMS
}

enum Months: String, CaseIterable {
    case JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER
}

enum API: String {
    case APIToken = "229c0077-47bd-499f-ae06-16ab1eee40be"
    case host = "https://kinopoiskapiunofficial.tech/"
    case filters = "api/v2.2/films/filters"
    case top = "api/v2.2/films/top?type=%@&page=%d"
    case premier = "api/v2.2/films/premieres?year=%d&month=%@"
    case images = "api/v2.2/films/%d/images?images?type=SCREENSHOT&page=1"
    var url: URL? {
        return URL(string: API.host.rawValue + self.rawValue)
    }
    
    func getTopURL(with topType: TopFilmsType, page: Int) -> URL? {
        let string = API.host.rawValue + self.rawValue
        let newString = String(format: string, topType.rawValue, page)
        return URL(string: newString)
    }
    
    func getPremierURL(with year: Int, month: Months) -> URL? {
        let string = API.host.rawValue + self.rawValue
        let newString = String(format: string, year, month.rawValue)
        return URL(string: newString)
    }
    
    
    
    
    func getImagesURL(with id: Int) -> URL? {
        let string = API.host.rawValue + self.rawValue
        let newString = String(format: string, id)
        print(string)
        print(newString)
        return URL(string: newString)
        
    }
}

