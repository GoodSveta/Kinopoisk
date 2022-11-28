//
//  Likes+CoreDataProperties.swift
//  
//
//  Created by mac on 21.04.22.
//
//

import Foundation
import CoreData


extension Likes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Likes> {
        return NSFetchRequest<Likes>(entityName: "Likes")
    }

    @NSManaged public var filmID: Int64
   
    @nonobjc public class func fetchRequest(where filmId: Int64) -> NSFetchRequest<Likes> {
        let request = NSFetchRequest<Likes>(entityName: "Likes")
        request.predicate = NSPredicate(format: "filmID == %d", filmId)
        return request
    }
}
