//
//  PremierFilmDB+CoreDataProperties.swift
//  
//
//  Created by mac on 14.04.22.
//
//

import Foundation
import CoreData


extension PremierFilmDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PremierFilmDB> {
        return NSFetchRequest<PremierFilmDB>(entityName: "PremierFilmDB")
    }

    @NSManaged public var kinopoiskID: Int64
    @NSManaged public var nameRu: String?
    @NSManaged public var nameEn: String?
    @NSManaged public var year: Int64
    @NSManaged public var posterURLPreview: String?
    @NSManaged public var posterURL: String?
    @NSManaged public var premiereRu: String?
    @NSManaged public var duration: Int64
    @NSManaged public var countries: NSSet?
    @NSManaged public var genres: NSSet?
    
    func getMappedPremierFilm() -> PremierFilm {
        return PremierFilm(kinopoiskID: Int(kinopoiskID),
                           nameRu: nameRu ?? "",
                           nameEn: nameEn ?? "",
                           year: Int(year),
                           posterURL: posterURL ?? "",
                           posterURLPreview: posterURLPreview ?? "",
                           countries: countries?.compactMap( { ($0 as! CountryDB).getMappedCountry() }) ?? [], //compactMap не возвращает nil
                           genres: genres?.compactMap({ ($0 as! GenreDB).getMappedGenre() }) ?? [],
                           duration: Int(duration),
                           premiereRu: premiereRu ?? "")
    }
    
    

}

// MARK: Generated accessors for countries
extension PremierFilmDB {

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
extension PremierFilmDB {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreDB)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreDB)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
