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
    private var targetLanguage: String = "ru"
    
    func translateWords() {
        let text = currentText
        translateNetworkService.translateLogic(message: text, language: targetLanguage) { [weak self] translated in
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
}

