//
//  GenreDB+CoreDataProperties.swift
//  
//
//  Created by mac on 14.04.22.
//
//

import Foundation
import CoreData


extension GenreDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreDB> {
        return NSFetchRequest<GenreDB>(entityName: "GenreDB")
    }

    @nonobjc public class func fetchRequest(by name: String) -> NSFetchRequest<GenreDB> {
        let request = NSFetchRequest<GenreDB>(entityName: "GenreDB")
        request.predicate = NSPredicate(format: "name == %@", name)
        return request
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var films: NSSet?
    @NSManaged public var premierFilms: NSSet?

    func getMappedGenre() -> Genre {
        return Genre(genre: name ?? "")
    }
    
    func setValues(by genre: Genre) {
        self.name = genre.genre
    }
    
    func setValues(by genreFiltered: GenreFiltered) {
        self.name = genreFiltered.genre
        self.id = Int64(genreFiltered.id)
    }
}

// MARK: Generated accessors for films
extension GenreDB {

    @objc(addFilmsObject:)
    @NSManaged public func addToFilms(_ value: FilmDB)

    @objc(removeFilmsObject:)
    @NSManaged public func removeFromFilms(_ value: FilmDB)

    @objc(addFilms:)
    @NSManaged public func addToFilms(_ values: NSSet)

    @objc(removeFilms:)
    @NSManaged public func removeFromFilms(_ values: NSSet)

}

// MARK: Generated accessors for premierFilms
extension GenreDB {

    @objc(addPremierFilmsObject:)
    @NSManaged public func addToPremierFilms(_ value: PremierFilmDB)

    @objc(removePremierFilmsObject:)
    @NSManaged public func removeFromPremierFilms(_ value: PremierFilmDB)

    @objc(addPremierFilms:)
    @NSManaged public func addToPremierFilms(_ values: NSSet)

    @objc(removePremierFilms:)
    @NSManaged public func removeFromPremierFilms(_ values: NSSet)

}
