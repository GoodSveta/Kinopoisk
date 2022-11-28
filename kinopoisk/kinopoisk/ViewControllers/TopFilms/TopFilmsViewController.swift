//
//  TopFilmsViewController.swift
//  kinopoisk
//
//  Created by mac on 16.03.22.
//
import NVActivityIndicatorView
import UIKit

class TopFilmsViewController: UIViewController {
   
    @IBOutlet weak var activityView: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
  
    private var films: [Film] = [] {
        didSet {
            tableView.performBatchUpdates {
                tableView.insertRows(at: films.enumerated().map { IndexPath(row: $0.offset, section: 0)}, with: .top)
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        activityView.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        getData()
    }
    
//    private func getData() {
//        NetworkServiceManager.shared.getTop(with: .TOP_250_BEST_FILMS) { [weak self] films in
//            self?.films = films
//            self?.activityView.stopAnimating()
//     
//            CoreDataManager.shared.addFilms(by: <#T##[Film]#>)
//            
//        } onError: { [weak self] error in
//            guard let error = error, let self = self else { return }
//            self.showAlert(with: error)
//        }
//    }
 
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "FilmTableViewCell")
    }
}

extension TopFilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell") as? FilmTableViewCell else { return UITableViewCell() }
        cell.setup(with: films[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension TopFilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "") { (contextualAction, view, boolValue) in
            
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [contextItem])
    
        return swipeAction
    }// это стандартная настройка активной ячейки
}
