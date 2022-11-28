//
//  PremiersViewController.swift
//  kinopoisk
//
//  Created by mac on 4.03.22.
//

import UIKit

class PremiersViewController: UIViewController {
    
    enum ExpandedCell: Int {
        case date, type, none
        
        var openedHeight: CGFloat {
            switch self {
            case .date: return 244.0
            case .type: return 218.0
            case .none: return 44.0
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentOpenedCell: ExpandedCell = .none {
        didSet {
            if currentOpenedCell == oldValue {
                currentOpenedCell = .none
            }
            
            tableView.performBatchUpdates(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "DateTableViewCell")
        tableView.register(UINib(nibName: "TypeFilmTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TypeFilmTableViewCell")
    }
}

extension PremiersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell") as? DateTableViewCell else { return UITableViewCell() }
            
            cell.resetButtonDidClick = {
                self.currentOpenedCell = .none
            }
            
            cell.dateDidChange = { _ in
                
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TypeFilmTableViewCell") as? TypeFilmTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        default: return UITableViewCell()
        }
    }
}

extension PremiersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = ExpandedCell(rawValue: indexPath.row) else { return }
        currentOpenedCell = selectedCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch currentOpenedCell {
        case .date: return indexPath.row == ExpandedCell.date.rawValue ? ExpandedCell.date.openedHeight : ExpandedCell.none.openedHeight
        case .type: return indexPath.row == ExpandedCell.type.rawValue ? ExpandedCell.type.openedHeight : ExpandedCell.none.openedHeight
        case .none: return ExpandedCell.none.openedHeight
        }
    }
}
