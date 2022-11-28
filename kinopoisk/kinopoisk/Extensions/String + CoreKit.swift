//
//  String + CoreKit.swift
//  kinopoisk
//
//  Created by mac on 2.04.22.
//

import Foundation

extension String {
    var localized: String {
        guard let url = Bundle.main.url(forResource: Settings.shared.currentLanguageCode, withExtension: "lproj"),
              let langBundle = Bundle(url: url) else { return self }
        return NSLocalizedString(self, bundle: langBundle, comment: "")
    }

}
