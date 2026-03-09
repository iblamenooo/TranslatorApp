//
//  TranslatorNetworkService.swift
//  TranslatorApp
//
//  Created by Nurtore on 25.01.2026.
//

import UIKit

class TranslatorNetworkService {
    func translateLogic(message:String, language:String,source:String, completion: @escaping (String?) -> Void) {
        let googleApi = "AIzaSyA6LXpVqzH5iO8SEluTOhVlflwuca_7ONY"
        
        let urlString = "https://translation.googleapis.com/language/translate/v2?key=\(googleApi)&q=\(message)&target=\(language)&source=\(source)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(TranslateResponse.self, from: data)
                let translatedText = decoded.data.translations.first?.translatedText
                completion(translatedText)
            }catch {
                print("Decoding error:", error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}



