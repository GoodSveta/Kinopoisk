//
//  CoreDataManager.swift
//  kinopoisk
//
//  Created by mac on 11.04.22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    enum CurrentStateLike {
        case added, removed
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "KinopoiskDataBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext //  для удобства обращения
    }
    
    func addFilms(by films: [Film]) {
        films.forEach { [weak self] film in
            guard let self = self else { return }
            let dbCurrentObject = getFilmFromDB(by: Int64(film.filmID))
            let filmDB = getFilmFromDB(by: Int64(film.filmID)) ?? FilmDB(context: context)
            filmDB.setValue(by: film)
           
            film.countries.forEach {
                let countryDB = getCountryFromDB(by: $0.country) ?? CountryDB(context: self.context)
                countryDB.setValues(by: $0)
                filmDB.addToCountries(countryDB)
            }
            
            film.genres.forEach {
                let genreDB = getGenreFromDB(by: $0.genre) ?? GenreDB(context: self.context)
                genreDB.setValues(by: $0)
                filmDB.addToGenres(genreDB)
                
            }
            if dbCurrentObject == nil {
                self.context.insert(filmDB)
            }
        }
        saveContext()
    } //сохранение в базу данных Положил на контекст далее обязательно вызвать сохранение
  
    func addFiltered(by filtered: Filtered) {
        filtered.genres.forEach { filter in
            let dbObject = getGenreFromDB(by: filter.genre)
            let genreDB = dbObject ?? GenreDB(context: self.context)
            genreDB.setValues(by: filter)
            
            if dbObject == nil {
                self.context.insert(genreDB)
            }
        }
        
        filtered.countries.forEach { filter in
            let dbObject = getCountryFromDB(by: filter.country)
            let countryDB = dbObject ?? CountryDB(context: self.context)
            countryDB.setValues(by: filter)
            
            if dbObject == nil {
                self.context.insert(countryDB)
            }
        }
        
    }
    
    func likeOrRemoveFilm(from filmId: Int64) -> CurrentStateLike {
        let fetchRequest = Likes.fetchRequest(where: filmId)
        
        guard let object = try? context.fetch(fetchRequest).first else {
            let like = Likes(context: context)
            like.filmID = filmId
            
            context.insert(like)
            NotificationCenter.default.post(name: NSNotification.Name("LikedDataBaseDidChange"), object: nil)
            saveContext()
            return CurrentStateLike.added
        }
        context.delete(object)
        saveContext()
        NotificationCenter.default.post(name: NSNotification.Name("LikedDataBaseDidChange"), object: nil)
        return CurrentStateLike.removed
    }//куда передавать фильм id и функция сама будет удалять или добавить. Если не находит в БД то добавитьБ и наобьоро если естьБ то удалить
    
    func isLikedFilm(from filmId: Int64) -> Bool? {
        let fetchRequest = Likes.fetchRequest(where: filmId)
        return try? context.fetch(fetchRequest).first != nil
    }
    
    func getAllFilmsFromDB(with page: Int) -> [Film] {
        let request = FilmDB.fetchRequest()
        request.fetchLimit = 20
        request.fetchOffset = (page - 1) * request.fetchLimit
        
        let sort = NSSortDescriptor(key: #keyPath(FilmDB.rating), ascending: false)
        request.sortDescriptors = [sort]
        
        guard let filmsDB = try? self.context.fetch(request) else { return [] }
        return filmsDB.map { $0.getMappedFilm() }
    }
    
    
    func clearDataBase() {
        deleteAllFilms()
        deleteAllCountries()
        deleteAllGenre()
    }
    
    func debugPring() {
        let request = CountryDB.fetchRequest()
        let objects = try! self.context.fetch(request)
        
        objects.forEach {
            print("id \($0.id), name \($0.name ?? "")")
        }
        
    }
    
    private func getFilmFromDB(by id: Int64) -> FilmDB? {
       let request = FilmDB.fetchRequest(with: id)
       return try? self.context.fetch(request).first
    
    }
    private func getLikedIds() -> [Int64] {
        let request = Likes.fetchRequest()
        return (try? self.context.fetch(request))?.compactMap { $0.filmID } ?? []
        // получим ид фильмов лайкнутых (т.к в этой БД Likes сохраняются только лайкнутые)
    }
    
    func getLikedFilms() -> [Film] {
        let request = FilmDB.fetchRequest(with: getLikedIds())
        return (try? self.context.fetch(request))?.compactMap { $0.getMappedFilm() } ?? []
    }
    
    private func getCountryFromDB(by name: String) -> CountryDB? {
        let request = CountryDB.fetchRequest(by: name)
       return try? self.context.fetch(request).first
    }
    
    private func getGenreFromDB(by name: String) -> GenreDB? {
        let request = GenreDB.fetchRequest(by: name)
        return try? self.context.fetch(request).first
    }
    
    private func deleteAllFilms() {
        let films = FilmDB.fetchRequest() // создаем запрос на доступ к БД
      

        do {
        let filmDB = try self.context.fetch(films) //забрать данные
            
            filmDB.forEach {
            self.context.delete($0)
            }
            self.saveContext() // только после этого удалится БД
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    private func deleteAllCountries() {
        let countries = CountryDB.fetchRequest() // создаем запрос на доступ к БД
      

        do {
        let countryDB = try self.context.fetch(countries) //забрать данные
            
            countryDB.forEach {
            self.context.delete($0)
            }
            self.saveContext() // только после этого удалится БД
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    
    private func deleteAllGenre() {
        let genre = GenreDB.fetchRequest() // создаем запрос на доступ к БД

        do {
        let genreDB = try self.context.fetch(genre) //забрать данные
            
            genreDB.forEach {
            self.context.delete($0)
            }
            self.saveContext() // только после этого удалится БД
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

