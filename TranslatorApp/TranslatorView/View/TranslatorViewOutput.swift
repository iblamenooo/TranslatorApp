//
//  TranslatorViewOutput.swift
//  TranslatorApp
//
//  Created by Nurtore on 23.01.2026.
//

import Foundation

protocol TranslatorViewOutput {
    func inputTextDidChange(_ text:String)
    func changeTranslationLanguage(language: Language)
    func changeSourceLanguage(language: Language)
    func addToFavorites()
    func deleteFavorite(at index:Int)
    func getFavoriteCount()->Int
    func getFavorite(index:Int)->FavoritesTranslation
    func didSelectFavorite(_ item: FavoritesTranslation)
}
