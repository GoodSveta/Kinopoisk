//
//  UIViewController + CoreKit.swift
//  kinopoisk
//
//  Created by mac on 27.01.22.
//

import UIKit

extension UIViewController {
    static var getInstanceViewController: UIViewController? {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController()
    }
    
    static func getViewController(with identifier: String) -> UIViewController? {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func showAlert(with messageError: String) {
        let alert = UIAlertController(title: nil, message: messageError, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
