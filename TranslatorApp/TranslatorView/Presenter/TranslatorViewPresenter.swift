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
    
    var favorites:[FavoritesTranslation] = []   
    
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
            guard !text.isEmpty else { return }
        }
    }
    
    func inputTextDidChange(_ text: String) {
        currentText = text
        translateWords()
        input?.updateFavoriteButton(isFavorite: isFavorite())
    }

    func addToFavorites() {
        guard !lastTranslatedText.isEmpty else { return }
        
        let newFavorite = FavoritesTranslation(
            sourceLang: sourceLanguage,
            targetedLang: targetLanguage,
            originalText:currentText,
            translatedText: lastTranslatedText
        )
        
        let alreadyExists = favorites.contains {
            $0.originalText == currentText &&
            $0.translatedText == lastTranslatedText
        }

        guard !alreadyExists else { return }
        
        favorites.insert(newFavorite, at: 0)
        input?.reloadTableView()
        
        input?.updateFavoriteButton(isFavorite: true)
    }
    
    func changeTranslationLanguage(language lang: Language) {
        targetLanguage = lang
        if !currentText.isEmpty { translateWords() }
    }
    
    func changeSourceLanguage(language lang: Language) {
        sourceLanguage = lang
        if !currentText.isEmpty { translateWords() }
    }
    
    func deleteFavorite(at index: Int) {
        favorites.remove(at: index)
        input?.reloadTableView()
    }
    
    func isFavorite() -> Bool {
        return favorites.contains {
            $0.originalText == currentText &&
            $0.translatedText == lastTranslatedText
        }
    }
    func didSelectFavorite(_ item: FavoritesTranslation) {
        // Sync internal state with the selected favorite
        self.currentText = item.originalText
        self.lastTranslatedText = item.translatedText
        self.sourceLanguage = item.sourceLang
        self.targetLanguage = item.targetedLang
        
        // Update the bookmark icon state immediately
        input?.updateFavoriteButton(isFavorite: true)
    }
    
    
}


