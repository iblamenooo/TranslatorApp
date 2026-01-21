//
//  ProfilePresenter.swift
//  TranslatorApp
//
//  Created by Nurtore on 25.12.2025.
//

import UIKit

class ProfilePresenter: ProfileViewOutput {
    weak var input: ProfileViewInput?
    private let networkService = NetworkService()
    private let nameKey = "saved_name"
    private let userKey = "saved_username"
    private let phoneKey = "saved_phoneNumber"
    private let imageKey = "saved_profile"
    
    func getRandomImage() {
        networkService.fetchRandomPhoto(query: "car") { [weak self] imageUrlString in
            guard let urlString = imageUrlString, let url = URL(string: urlString) else { return }
            
            self?.networkService.downloadImage(from: url) { image in
                guard let image = image else { return }
                print("Downloaded")
                
                DispatchQueue.main.async {
                    self?.input?.updateImage(image: image)
                }
            }
        }
    }
    func saveUserData(text: String, field: String) {
        let defaults = UserDefaults.standard
        if field=="Name" {
            defaults.set(text, forKey: nameKey)
        } else if field=="Username" {
            defaults.set(text, forKey: userKey)
        } else if field=="Number" {
            defaults.set(text, forKey: phoneKey)
        }
    }

    func loadUserData() {
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: nameKey)
        let user = defaults.string(forKey: userKey)
        let phone = defaults.string(forKey: phoneKey)
        input?.updateFields(name: name ?? "", username: user ?? "", phone: phone ?? "")
        if let imageData = defaults.data(forKey: imageKey), let image = UIImage(data: imageData) {
            input?.updateImage(image: image)
        }
    }
}
