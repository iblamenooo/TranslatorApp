//
//  TranslatorViewInput.swift
//  TranslatorApp
//
//  Created by Nurtore on 24.01.2026.
//
import UIKit

protocol TranslatorViewInput: AnyObject {
    func showTranslation(_ translation: String)
    func reloadTableView()
    func updateFavoriteButton(isFavorite: Bool)
    
}
