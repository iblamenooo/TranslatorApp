//
//  TranslatorViewOutput.swift
//  TranslatorApp
//
//  Created by Nurtore on 23.01.2026.
//

import Foundation

protocol TranslatorViewOutput {
    func inputTextDidChange(_ text:String)
    func changeTranslationLanguage(language: String)
    func changeSourceLanguage(language: String)
    func addToFavorites()
    func getFavoriteCount()->Int
    func getFavorite(index:Int)->FavoritesTranslation
}
