//
//  TranslateResponse.swift
//  TranslatorApp
//
//  Created by Nurtore on 26.01.2026.
//
import Foundation

struct TranslateResponse: Decodable {
    let data: TranslateData
}

struct TranslateData: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
