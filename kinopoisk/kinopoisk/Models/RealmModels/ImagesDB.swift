//
//  ImagesDB.swift
//  kinopoisk
//
//  Created by mac on 5.10.22.
//

import RealmSwift

class ImageDB: Object {
    @Persisted var imageURL: String = ""
    @Persisted var previewURL: String = ""
    @Persisted var filmID: Int = -1
    
    convenience init(image: Image, filmID: Int) {
        self.init()
        
        self.filmID = filmID
        self.imageURL = image.imageURL
        self.previewURL = image.previewURL
    }
    
    override class func primaryKey() -> String? {
        return "imageURL"
    }
    
    func mappedImage() -> Image {
        return Image(imageURL: self.imageURL, previewURL: self.previewURL)
    }
}
