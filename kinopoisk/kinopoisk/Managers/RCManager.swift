//
//  RCManager.swift
//  kinopoisk
//
//  Created by mac on 11.04.22.
//

import FirebaseRemoteConfig
import UIKit

enum ValueKey: String {
    case showContacts
    case mapType
}

class RCManger {
    static let shared = RCManger()
    
    init() {
        loadDefaultValues()
        activateDebugMode()
    }
    
    private func activateDebugMode() {
        let debugSettings = RemoteConfigSettings()
        RemoteConfig.remoteConfig().configSettings = debugSettings
    }
    
    private func loadDefaultValues() {
        let defaultValue: [String: Any?] = [
            ValueKey.mapType.rawValue: "apple",
            ValueKey.showContacts.rawValue: true
        ]
        
        RemoteConfig.remoteConfig().setDefaults(defaultValue as? [String: NSObject])
    }
    
    func connect(_ onCompleted: @escaping (() -> ())) {
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { status, error in
            if let error = error {
                print(error.localizedDescription)
                onCompleted()
                return
            }
            
            RemoteConfig.remoteConfig().activate { status, error in
                onCompleted()
            }
        }
    }
    
    func string(forKey key: ValueKey) -> String? {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue
    }
    
    func bool(forKey key: ValueKey) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
    
}


