//
//  TranslatorViewPresenter.swift
//  TranslatorApp
//
//  Created by Nurtore on 23.01.2026.
//

import UIKit

class TranslatorViewPresenter: TranslatorViewOutput {
    
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
                self.input?.showTranslation(translated ?? "Error")
            }
            guard !text.isEmpty else { return }
        }
        
    }
    
    func inputTextDidChange(_ text: String) {
        currentText = text
        translateWords()
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

