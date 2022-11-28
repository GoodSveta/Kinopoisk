//
//  MainViewController.swift
//  kinopoisk
//
//  Created by mac on 4.02.22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var userClickAllLikesButton: (() -> ())?
    var likedFilms: [Film] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userClickAllLikesButton = {
            guard let vc = PremiersViewController.getInstanceViewController as? PremiersViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        setupUI()
        likedFilms = CoreDataManager.shared.getLikedFilms()
        
        NotificationCenter.default.addObserver(self, selector: #selector(likedDataBaseDidChange), name: NSNotification.Name("LikedDataBaseDidChange"), object: nil) // будет следить за изменением БД и обновлять likedFilms. Нотификацию надо послать при добавлении или удалиии лайков в фукнции likeOrRemoveFilm
    }
    
    @objc
    func likedDataBaseDidChange() {
        likedFilms = CoreDataManager.shared.getLikedFilms()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "PremiersFilmsTableViewCell", bundle: nil), forCellReuseIdentifier: "PremiersFilmsTableViewCell")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedFilms.isEmpty ? 0 : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PremiersFilmsTableViewCell") as? PremiersFilmsTableViewCell else {
            return UITableViewCell()
        }
        cell.films = likedFilms
        cell.titleLabel.text = "Избранное"
        cell.dateLabel.isHidden = true
        cell.userClickAllPremiersButton = self.userClickAllLikesButton
      
        cell.selectionStyle = .none
        return cell
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
         return 270.0
       
        }
}

    

