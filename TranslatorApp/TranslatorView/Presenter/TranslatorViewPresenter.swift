//
//  TranslatorViewPresenter.swift
//  TranslatorApp
//
//  Created by Nurtore on 23.01.2026.
//

import UIKit

enum Language: String, CaseIterable {
    case en
    case ru
    case fr
    
    var title: String {
        switch self {
            case .en: return "English (USA)"
            case .ru: return "Russian (Russia)"
            case .fr: return "France (France)"
        }
    }
}

struct FavoritesTranslation  {
    let sourceLang:Language
    let targetedLang:Language
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
    private var sourceLanguage: Language = .en
    private var targetLanguage: Language = .ru
    
    func translateWords() {
        let text = currentText
        if sourceLanguage==targetLanguage {
            self.input?.showTranslation(text)
            return
        }
        translateNetworkService.translateLogic(message: text, language: targetLanguage.rawValue, source:sourceLanguage.rawValue) { [weak self] translated in
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
        guard !lastTranslatedText.isEmpty else { return }
        let newFavorite = FavoritesTranslation(
            sourceLang: sourceLanguage,
            targetedLang: targetLanguage,
            originalText:currentText,
            translatedText: lastTranslatedText
        )
        print("addTofavorites")
        favorites.insert(newFavorite, at: 0)
        input?.reloadTableView()
    }
    
    func changeTranslationLanguage(language lang: Language) {
        targetLanguage = lang
        if !currentText.isEmpty { translateWords() }
    }
    
    func changeSourceLanguage(language lang: Language) {
        sourceLanguage = lang
        if !currentText.isEmpty { translateWords() }
    }
}

//enum
