//
//  FilmTableViewCell.swift
//  kinopoisk
//
//  Created by mac on 21.02.22.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var containerActions: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameFilmLabel: UILabel!
   
    var filmId:Int64 = -1
    
    var liked: Bool {
        return CoreDataManager.shared.isLikedFilm(from: filmId) ?? false
    } // будет возвращать лайкнут элемент или нет
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_ :)))
        panGesture.delegate = self
        containerView.addGestureRecognizer(panGesture)
    }
    @objc private func panGestureAction(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let translation = sender.translation(in: containerView)
            sender.setTranslation(.zero, in: containerView) // движение view CGPoint по х
            guard translation.x < 0 || containerView.frame.origin.x < 0 else {return} // проверка на отрицательность чтобы двигать только влево
            containerView.frame.origin.x += translation.x //измененить расположение view отсносительно движения
        case .cancelled, .ended, .failed:
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                if self.containerView.frame.origin.x > -self.containerActions.bounds.width {
                    self.containerView.frame.origin.x = -self.containerActions.bounds.width //если  больше чем шарина контейнера то задать х минимум ширина контейнера(чтобы останавливалось на начале контейнера экшенс )
            } else {
                if self.containerView.frame.origin.x > 0 {
                    self.containerView.frame.origin.x = 0 // если больше нуля то 0
                } else {
                    if abs(self.containerView.frame.origin.x) > (self.containerActions.bounds.width/2) {
                        self.containerView.frame.origin.x = -self.containerActions.bounds.width //  если останавливаю на середине меньше чем половина, то не закрывать контейнер
                    } else {
                        self.containerView.frame.origin.x = 0 //если уехал больше чем наполовину
                    }
                }//  если останавливаю на середине
            }
        }
        default: break
        }
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
    }

    func setup(with film: Film) {
        filmId = Int64(film.filmID)
        nameFilmLabel.text = film.nameRu
        likeLabel.text = CoreDataManager.shared.likeOrRemoveFilm(from: filmId) == .added ? "Unlike" : "Like"
        // лайкни или удали фильм который фильмид и если тут вернется что фильм добавлен то онлйк
//        posterImageView.image = UIImage(named: film.poster)
        
        DispatchQueue.global().async { [weak self] in
            if let posterURL = URL(string: film.posterURLPreview),
               let data = try? Data(contentsOf: posterURL, options: .alwaysMapped) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(data: data)
                }
              
        }
    }
        durationLabel.text = film.filmLength
        ratingLabel.text = film.rating
//        descriptionLabel.text = film.description
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
    }
    
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // метод чтобы работало два жеста и пан и ячейка
    }
    
    
  
    
}

