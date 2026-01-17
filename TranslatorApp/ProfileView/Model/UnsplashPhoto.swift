//
//  UnsplashPhoto.swift
//  TranslatorApp
//
//  Created by Nurtore on 09.01.2026.
//

import Foundation

struct UnsplashPhoto: Decodable {
    let urls: PhotoURLs
}

struct PhotoURLs: Decodable {
    let regular: String
}
