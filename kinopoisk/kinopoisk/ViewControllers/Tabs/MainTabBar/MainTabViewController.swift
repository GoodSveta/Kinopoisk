//
//  MainViewController.swift
//  kinopoisk
//
//  Created by mac on 2.02.22.
//

import UIKit

enum ColorCheker: Int {
    case white, black
}

//class Checker {
//    var color: ColorCheker
//    var numberCell: Int
////    init(color: ColorCheker, numberCell: Int) {}
//
//
    
    
    
//}


class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = #colorLiteral(red: 0.08326526731, green: 0.08956695348, blue: 0.09548642486, alpha: 1)
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        delegate = self
        
//        viewControllers = [ProfileViewController.getInstanceViewController!, и т.д] -это добавление через код в таббар всех контроллеров
    
    }
    


}

//        if viewController.isKind(of: SearchViewController.self){} // проверяет все уровни наследования

extension MainTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if (viewController as? UINavigationController)?.viewControllers.first is SearchViewController {
            if !Settings.shared.isSubscriber {
                guard let vc = PremiumViewController.getInstanceViewController else { return false }
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
                return false
            }
        }
        
        return true
    }
}
