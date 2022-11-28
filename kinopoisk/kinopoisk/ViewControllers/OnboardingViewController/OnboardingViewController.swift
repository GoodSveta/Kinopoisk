//
//  OnboardingViewController.swift
//  kinopoisk
//
//  Created by mac on 26.01.22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var postersView: UIView!
    
    @IBOutlet weak var centerPostr: UIImageView!
    
    
    private lazy var downloadImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(systemName: "arrow.down.circle"))
     
        imageView.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: 100.0, height: 100.0))
        imageView.alpha = 0.0
        centerPostr.addSubview(imageView)
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.isHidden = false
        
        setupUI()
        scrollView.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupAnimation()
    }
    
    private func setupUI() {
        labelFirst.alpha = 0
        labelSecond.alpha = 0
        pageControl.alpha = 0
        
        postersView.bringSubviewToFront(centerPostr)
        postersView.subviews.forEach { $0.layer.cornerRadius = 8.0 }
        centerPostr.layer.cornerRadius = 8.0
        downloadImageView.center = CGPoint(x: centerPostr.frame.size.width / 2.0, y: centerPostr.frame.size.height / 2.0)
        
    }
    private func setupAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]) {
            self.labelFirst.alpha = 1
            self.labelSecond.alpha = 1
            self.pageControl.alpha = 1
        } completion: { _ in
    }
    }

}
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let onePageOffset = scrollView.contentSize.width / CGFloat(pageControl.numberOfPages)
        let diffScale = (scrollView.contentOffset.x / onePageOffset) * 0.1
//       alfa changed with 1  -> 0
//         abs делает с положительного отрицательное число (по модулю)
        guard diffScale <= 0.1 else {
        let newAlpha = 1 - ((scrollView.contentOffset.x / onePageOffset) - 1)
        labelSecond.alpha = newAlpha
        pageControl.alpha = newAlpha
        postersView.alpha = newAlpha
        downloadImageView.alpha = newAlpha
        centerPostr.alpha = newAlpha
        return
            
        }
        
        downloadImageView.alpha = (scrollView.contentOffset.x / onePageOffset)
        let newTransform = CGAffineTransform(scaleX: 1.0 - diffScale, y: 1.0 - diffScale).rotated(by: diffScale)
      
        
        postersView.transform = newTransform
        centerPostr.transform = CGAffineTransform(rotationAngle: -diffScale)
            .scaledBy(x: 1.0 + diffScale * 6,
                      y: 1.0 + diffScale * 6)
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let onePageOffset = scrollView.contentSize.width / CGFloat(pageControl.numberOfPages)
        pageControl.currentPage = Int(scrollView.contentOffset.x / onePageOffset)
        
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            Settings.shared.onboardingCompleted = true
          guard let mainVC = MainViewController.getInstanceViewController else { return }
            navigationController?.viewControllers = [mainVC]
        }
        
        
//        UserDefaults.standard.set(5, forKey: "intager value") //  положить любое значение это set
//        UserDefaults.standard.integer(forKey: "intager value") //забрать любое значение (тип) это object
//       UserDefaults это стандартная база данных где мы можем хранить пары ключ значения и получать данные после запуска приложения
        
    }
   

    
}
