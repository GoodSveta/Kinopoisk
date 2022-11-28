//
//  PremiersFilmsTableViewCell.swift
//  kinopoisk
//
//  Created by mac on 2.03.22.
//

import UIKit
//@objc
//protocol PremiersFilmsTableViewCellDelegate: AnyObject {
//    @objc optional func userClickAllPremiersButton()
//}

class PremiersFilmsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userClickAllPremiersButton: (() -> ())?
    var userClickPremierFilm: ((Int) -> ())?
    var films: [Film] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    //weak var delegate: PremiersFilmsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PreviewFilmCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PreviewFilmCollectionViewCell")
    }
    
    @IBAction func allButtonAction(_ sender: UIButton) {
        userClickAllPremiersButton?()
//        delegate?.userClickAllPremiersButton?()
    }
}

extension PremiersFilmsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewFilmCollectionViewCell", for: indexPath) as? PreviewFilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: films[indexPath.row])
        return cell
    }
}

extension PremiersFilmsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110.0, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userClickPremierFilm?(indexPath.item)
    }
}
