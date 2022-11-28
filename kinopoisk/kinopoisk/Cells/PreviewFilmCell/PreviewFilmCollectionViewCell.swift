//
//  PreviewFilmCollectionViewCell.swift
//  kinopoisk
//
//  Created by mac on 27.02.22.
//

import UIKit

class PreviewFilmCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var nameFilmLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    func setup(with film: Film) {
        nameFilmLabel.text = film.nameRu
        genreLabel.text = film.genres.first?.genre ?? ""
    
}
}
