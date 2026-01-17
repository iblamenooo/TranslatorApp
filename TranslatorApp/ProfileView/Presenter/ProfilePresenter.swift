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
    func getRandomImage() {
            networkService.fetchRandomPhoto { [weak self] imageUrlString in
                guard let urlString = imageUrlString,
                      let url = URL(string: urlString),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.input?.updateImage(image: image)
                }
            }
        }
}
