//
//  ProfilePresenter.swift
//  TranslatorApp
//
//  Created by Nurtore on 25.12.2025.
//

import UIKit

class ProfilePresenter {
    weak var input:ProfileViewInput?
}


extension ProfilePresenter:ProfileViewOutput {
    func getRandomImage() {
        print("2")
        let person = UIImage(systemName: "person")!
        input?.updateImage(image: person)
    }
    
    
    
}
