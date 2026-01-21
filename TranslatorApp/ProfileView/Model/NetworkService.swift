//
//  NetworkService.swift
//  TranslatorApp
//
//  Created by Nurtore on 09.01.2026.
//

import UIKit

import UIKit

class NetworkService {
    let urlString: String = "https://api.unsplash.com/photos/random?client_id=t7cl4cZkTOw_V9pKAUIlXlurBWpcEUPO40ItYqAQ4qY"
    
    func fetchRandomPhoto(query: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: urlString) else { return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else { return }
            do {
                let result = try JSONDecoder().decode(UnsplashPhoto.self, from: data)
                completion(result.urls.regular)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            UserDefaults.standard.set(data, forKey: "saved_profile")
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
