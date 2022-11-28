//
//  FilmDB+CoreDataProperties.swift
//  
//
//  Created by mac on 14.04.22.
//
//

import Foundation
import CoreData


extension FilmDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmDB> {
        return NSFetchRequest<FilmDB>(entityName: "FilmDB")
    }
    
    @nonobjc public class func fetchRequest(with filmID: Int64) -> NSFetchRequest<FilmDB> {
        let request = NSFetchRequest<FilmDB>(entityName: "FilmDB")
        request.predicate = NSPredicate(format: "filmID == %d", filmID) //предикат
    
//    пример:
//        let yearsArray = [2020, 2021, 2022, 1986]
//        NSPredicate(format: "year in %@", yearsArray)
        
        return request
    }
    
    @nonobjc public class func fetchRequest(with likedIds: [Int64]) -> NSFetchRequest<FilmDB> {
        let request = NSFetchRequest<FilmDB>(entityName: "FilmDB")
        request.predicate = NSPredicate(format: "filmID IN %@", likedIds)
        return request //массив ид фильмов вернем фильмы ид которых будут входить в этот массив
    }
    
    @NSManaged public var filmID: Int64
    @NSManaged public var filmLenght: String?
    @NSManaged public var nameEn: String?
    @NSManaged public var nameRu: String?
    @NSManaged public var posterURL: String?
    @NSManaged public var posterURLPreview: String?
    @NSManaged public var rating: String?
    @NSManaged public var ratingVoteCount: Int64
    @NSManaged public var year: String?
    @NSManaged public var countries: NSSet?
    @NSManaged public var genres: NSSet?
   
    func getMappedFilm() -> Film {
        return Film(filmID: Int(filmID),
                    nameRu: nameRu ?? "",
                    nameEn: nameEn ?? "",
                    year: year ?? "",
                    filmLength: filmLenght ?? "",
                    countries: countries?.compactMap( { ($0 as! CountryDB).getMappedCountry() }) ?? [], //compactMap не возвращает nil
                    genres: genres?.compactMap({ ($0 as! GenreDB).getMappedGenre() }) ?? [],
                    rating: rating ?? "",
                    ratingVoteCount: Int(ratingVoteCount),
                    posterURL: posterURL ?? "",
                    posterURLPreview: posterURLPreview ?? "",
                    ratingChange: nil)
    }
    
    // чтобы не обращаться напрямую к обьектам БД надо достать этот обьект и конвертнуть его
    func setValue(by film: Film) {
        self.filmID = Int64(film.filmID)
        self.filmLenght = film.filmLength
        self.nameEn = film.nameEn
        self.nameRu = film.nameEn
        self.posterURL = film.posterURL
        self.posterURLPreview = film.posterURLPreview
        self.rating = film.rating
        self.ratingVoteCount = Int64(film.ratingVoteCount)
        self.year = film.year
    }
}

// MARK: Generated accessors for countries
extension FilmDB {

    @objc(addCountriesObject:)
    @NSManaged public func addToCountries(_ value: CountryDB)

    @objc(removeCountriesObject:)
    @NSManaged public func removeFromCountries(_ value: CountryDB)

    @objc(addCountries:)
    @NSManaged public func addToCountries(_ values: NSSet)

    @objc(removeCountries:)
    @NSManaged public func removeFromCountries(_ values: NSSet)

}

// MARK: Generated accessors for genres
extension FilmDB {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreDB)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreDB)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
