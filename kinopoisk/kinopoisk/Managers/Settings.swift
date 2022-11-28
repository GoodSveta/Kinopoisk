//
//  Settings.swift
//  kinopoisk
//
//  Created by mac on 2.02.22.
//
// почитать сингл то про статик, гет, сет
import UIKit

class Settings: NSObject {
    enum UserDefaultsKeys: String {
        case onboardingCompleted
        case isAuth
        case avatar
        case language
    }

    
    let lanCode = ["en", "ru", "ar"]
    static let shared = Settings()
    
    var onboardingCompleted: Bool {
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.onboardingCompleted.rawValue) }
        get { return UserDefaults.standard.bool(forKey: UserDefaultsKeys.onboardingCompleted.rawValue) }
    }
    
    var isAuth: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isAuth.rawValue)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AuthStateDidChange"), object: nil)
            
            if !newValue { avatar = nil }
        }
        get { return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAuth.rawValue) }
    }
    
    var avatar: UIImage? {
        set {
            isEmptyAvatar = newValue == nil
            if let dataImage = newValue?.jpegData(compressionQuality: 0.96) {
                UserDefaults.standard.set(dataImage, forKey: UserDefaultsKeys.avatar.rawValue)
            } else {
                UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.avatar.rawValue)
            }
        }
        
        get {
            if let dataImage = UserDefaults.standard.data(forKey: UserDefaultsKeys.avatar.rawValue) {
                return UIImage(data: dataImage)
            }
            
            return UIImage(named: "empty_avatar_secret")
        }
    }
    
    var currentLanguageCode: String {
        set {
            if let index = lanCode.firstIndex(of: newValue) {
                UserDefaults.standard.set(index, forKey: UserDefaultsKeys.language.rawValue)
            }
        }
        get {
            let indexCode = UserDefaults.standard.integer(forKey: UserDefaultsKeys.language.rawValue)
                        return lanCode[indexCode]
        }
    }
    
    
    var isEmptyAvatar: Bool
    
    var isSubscriber = true
    
    override init() {
        isEmptyAvatar = UserDefaults.standard.data(forKey: UserDefaultsKeys.avatar.rawValue) == nil
        
        super.init()
    }
}
