//
//  MediaViewController.swift
//  kinopoisk
//
//  Created by mac on 4.02.22.
//

import UIKit

class MediaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    
    var userClickAllPremiersButton: (() -> ())?
    var userClickPremierFilm: ((Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmTableViewCell")
        tableView.register(UINib(nibName: "PremiersFilmsTableViewCell", bundle: nil), forCellReuseIdentifier: "PremiersFilmsTableViewCell")
        
        userClickAllPremiersButton = {
            guard let vc = PremiersViewController.getInstanceViewController as? PremiersViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        userClickPremierFilm = { indexFilm in
//            guard let vc = DetailFilmViewController.getInstanceViewController as? DetailFilmViewController else { return }
//            vc.film = self.films[indexFilm]
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
}

extension MediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        default: return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PremiersFilmsTableViewCell") as? PremiersFilmsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.userClickAllPremiersButton = self.userClickAllPremiersButton
            cell.userClickPremierFilm = self.userClickPremierFilm
            
            //cell.delegate = self
            cell.selectionStyle = .none
            return cell
        default: return UITableViewCell()
        }
    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0, 2: return "Section header \(section)"
//        default: return nil
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        switch section {
//        case 0, 1: return "Section footer \(section)"
//        default: return nil
//        }
//    }
}

extension MediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 44.0
        case 1: return 270.0
        default: return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == 0 else { return }
        guard let vc = TopFilmsViewController.getInstanceViewController as? TopFilmsViewController else { return }
//        vc.film = films[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

//extension MediaViewController: PremiersFilmsTableViewCellDelegate {
//    func userClickAllPremiersButton() {
//        guard let vc = PremiersViewController.getInstanceViewController as? PremiersViewController else { return }
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
