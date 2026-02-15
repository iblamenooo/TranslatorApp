//
//  TranslatorViewPresenter.swift
//  TranslatorApp
//
//  Created by Nurtore on 23.01.2026.
//

import UIKit

struct FavoritesTranslation  {
    let sourceLang:String
    let targetedLang:String
    let originalText:String
    let translatedText:String
}

class TranslatorViewPresenter: TranslatorViewOutput {
    func getFavoriteCount() -> Int {
        favorites.count
    }
    
    func getFavorite(index: Int) -> FavoritesTranslation {
        favorites[index]
    }
    
    var favorites:[FavoritesTranslation] = []   //where it all stores
    
    private var lastTranslatedText: String = ""
    
    weak var input: TranslatorViewInput?
    
    private let translateNetworkService = TranslatorNetworkService()
    
    private var currentText: String = ""
    private var sourceLanguage: String = "en"
    private var targetLanguage: String = "ru"
    
    func translateWords() {
        let text = currentText
        if sourceLanguage==targetLanguage {
            self.input?.showTranslation(text)
            return
        }
        translateNetworkService.translateLogic(message: text, language: targetLanguage, source:sourceLanguage) { [weak self] translated in
            guard let self else { return }
            DispatchQueue.main.async {
                let result = translated ?? "Error"
                self.lastTranslatedText = result
                self.input?.showTranslation(translated ?? "Error")
            }
            guard text.isEmpty else { return }
        }
    }
    
    func inputTextDidChange(_ text: String) {
        currentText = text
        translateWords()
    }
    //MArk - addFavorites logic
    func addToFavorites() {
        print("AddRo")
        guard !lastTranslatedText.isEmpty else { return }
        let newFavorite = FavoritesTranslation(sourceLang: sourceLanguage,targetedLang: targetLanguage,originalText:currentText, translatedText: lastTranslatedText)
        print("addTofavorites")
        favorites.insert(newFavorite, at: 0)
        input?.reloadTableView()
    }
    
    func changeTranslationLanguage(language: String) {
        if language == "English (USA)" {
            targetLanguage = "en"
        } else if language == "Russian (Russia)" {
            targetLanguage = "ru"
        } else if language == "France (France)" {
            targetLanguage = "fr"
        }
        if !currentText.isEmpty {
            translateWords()
        }
    }
    
    func changeSourceLanguage(language: String) {
        if language == "English (USA)" {
            sourceLanguage = "en"
        } else if language == "Russian (Russia)" {
            sourceLanguage = "ru"
        } else if language == "France (France)" {
            sourceLanguage = "fr"
        }
        if !currentText.isEmpty {
            translateWords()
        }
    }
}

//enum
