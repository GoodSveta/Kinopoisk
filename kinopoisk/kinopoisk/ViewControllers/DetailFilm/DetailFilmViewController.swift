//
//  DetailFilmViewController.swift
//  kinopoisk
//
//  Created by mac on 27.02.22.
//

import UIKit
import RealmSwift

class DetailFilmViewController: UIViewController {
    var film: Film!
    private var observerImageToken: NotificationToken?
    
    deinit {
        observerImageToken?.invalidate()// в моент удаления удалить
        observerImageToken = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        observerImageToken = RealmManager.shared.getObserverImages(with: film.filmID).observe({ collection in
//            switch collection {
//            case.initial(let collection): // когда первый раз инициализируется(вернется массив исходных, какие они там есть)
//                print(collection.count)
////            case.update(collection, deletions: let del, insertions: let ins, modifications: let mod):
////                print(collection.count)
//                print("deleted")
//                print(del)
//                print("inserted")
//                print(ins)
//                print("modification")
//                print(mod)
//            default: break
//            }
//        })
       
    }
    

   
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
