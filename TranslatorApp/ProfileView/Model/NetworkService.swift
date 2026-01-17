//
//  NetworkService.swift
//  TranslatorApp
//
//  Created by Nurtore on 09.01.2026.
//

import Foundation

class NetworkService {
    let urlString = "https://api.unsplash.com/photos/random?client_id=TgCKrtfYHFxztSOY4Aq1vI4jibatqw9E9bAJa6_2sc8"
    func fetchRandomPhoto(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let result = try? JSONDecoder().decode(UnsplashPhoto.self, from: data)
            completion(result?.urls.regular)
        }.resume()
    }
}
