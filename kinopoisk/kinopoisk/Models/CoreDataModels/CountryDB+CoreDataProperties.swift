//
//  CountryDB+CoreDataProperties.swift
//  
//
//  Created by mac on 14.04.22.
//
//

import Foundation
import CoreData


extension CountryDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryDB> {
        return NSFetchRequest<CountryDB>(entityName: "CountryDB") // риквест позволяет забрать значение из базы даннх
    }

    @nonobjc public class func fetchRequest(by name: String) -> NSFetchRequest<CountryDB> {
       let request = NSFetchRequest<CountryDB>(entityName: "CountryDB")
        request.predicate = NSPredicate(format: "name == %@", name)
        return request
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var films: NSSet?
    @NSManaged public var premierFilms: NSSet?

    func getMappedCountry() -> Country {
        return Country(country: name ?? "")
    }
    
    func setValues(by country: Country) {
        self.name = country.country
    }
    
    func setValues(by countryFiltered: CountryFiltered) {
        self.name = countryFiltered.country
        self.id = Int64(countryFiltered.id)
    }
}

// MARK: Generated accessors for films
extension CountryDB {

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
extension CountryDB {

    @objc(addPremierFilmsObject:)
    @NSManaged public func addToPremierFilms(_ value: PremierFilmDB)

    @objc(removePremierFilmsObject:)
    @NSManaged public func removeFromPremierFilms(_ value: PremierFilmDB)

    @objc(addPremierFilms:)
    @NSManaged public func addToPremierFilms(_ values: NSSet)

    @objc(removePremierFilms:)
    @NSManaged public func removeFromPremierFilms(_ values: NSSet)

}
