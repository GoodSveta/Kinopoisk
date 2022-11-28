//
//  ProfileViewController.swift
//  kinopoisk
//
//  Created by mac on 4.02.22.
//

import UIKit



class ProfileViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var signInView: SignInView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    
    }
    
    private func setupUI() {
        if Settings.shared.isAuth {
            avatarImageView.image = Settings.shared.avatar
        }
        setLocalization()
    }
        private func setLocalization() {
            signInView.text = Settings.shared.isAuth ? "logout_text".localized : "login_text".localized
            
        }
        

    @IBAction func signInSwipeGestureRecognizer(_ sender: Any) {
        Settings.shared.isAuth = !Settings.shared.isAuth
        setupUI()
    }
    
    @IBAction func avatarTapGestureRecognizer(_ sender: Any) {
        guard Settings.shared.isAuth else { return }
        setupUI()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let viewAvatar = UIAlertAction(title: "Посмотреть", style: .default) { _ in
            guard let vc = ShowAvatarViewController.getInstanceViewController as? ShowAvatarViewController else {return}
            vc.image = self.avatarImageView.image
            
            self.present(vc, animated: true, completion: nil)
            
        }
        let changeAvatar = UIAlertAction(title: "Изменить", style: .default) { _ in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = true //возможность изменить картинку
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let removeAvatar = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            Settings.shared.avatar = nil
            self.setupUI()
        }
        
    alert.addAction(cancel)
        if Settings.shared.isEmptyAvatar {
            alert.addAction(viewAvatar)
        }
 
    alert.addAction(changeAvatar)
        if !Settings.shared.isEmptyAvatar{
            alert.addAction(removeAvatar)
        }
  
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        Settings.shared.currentLanguageCode = Settings.shared.lanCode[sender.tag]
        setLocalization()

        
    }
    
    
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.avatarImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    } //editid вернет измененную картинку
}
