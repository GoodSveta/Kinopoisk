//
//  RealmManager.swift
//  kinopoisk
//
//  Created by mac on 5.10.22.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    func addImages(images: [Image], filmID: Int) {
        images.forEach {
            let image = ImageDB(image: $0, filmID: filmID)
            
            do {
                try self.realm.write({
                    self.realm.add(image, update: .modified)
                    print("added")
                })
                //обратиться к Реалму и вызывать запись (значение в реалм)
            } catch(let e) {
                print(e.localizedDescription)
            }
        }
    }
    
    func getImages(with filmID: Int) -> [Image] {
        return realm.objects(ImageDB.self).filter("filmID == %d", filmID).map { $0.mappedImage()}
    }
    
    func getObserverImages(with filmID: Int) -> Results<ImageDB> {
        return realm.objects(ImageDB.self).filter("filmID == %d", filmID)
    }
}
