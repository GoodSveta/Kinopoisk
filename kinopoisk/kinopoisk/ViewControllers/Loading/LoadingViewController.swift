//
//  LoadingViewController.swift
//  kinopoisk
//
//  Created by mac on 26.01.22.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        RCManger.shared.connect {
            [weak self] in NetworkServiceManager.shared.getFilters(onCompleted: { filtered in
                DispatchQueue.main.async {
                CoreDataManager.shared.addFiltered(by: filtered)
                self?.startAnimation()
                }
            }, onError: { _ in
                DispatchQueue.main.async {
                    self?.startAnimation()
                }
            })
        }
       
        
    }
    private func startAnimation() {
        UIView.animate(withDuration: 1.0,
                       delay: 1.0,
                       options: [.curveEaseInOut]) {
            self.titleLabel.alpha = 0
            self.authorLabel.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: [.curveEaseInOut]) {
//                self.videoView.alpha = 0.0
            } completion: { [weak self] _ in
                if Settings.shared.onboardingCompleted {
                    guard let mainTabViewController = MainTabViewController.getInstanceViewController else { return }
                    UIApplication.shared.keyWindow?.rootViewController = mainTabViewController
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                } else {
                    guard let onboardingViewController = OnboardingViewController.getInstanceViewController else { return }
                    UIApplication.shared.keyWindow?.rootViewController = onboardingViewController
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                }
                
//                self?.clearMediaObjects()
            }
                
            }
        }

    }
    
    



