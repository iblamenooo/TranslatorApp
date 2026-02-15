//
//  ViewController.swift
//  TranslatorApp
//
//  Created by Nurtore on 21.12.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let presenter = ProfilePresenter()
    
    private lazy var output: ProfileViewOutput = presenter

    private lazy var profileImageView: UIImageView = {
        let imgvw = UIImageView()
        imgvw.image = UIImage(named: "profile_photo2")
        imgvw.layer.cornerRadius = 60
        imgvw.clipsToBounds = true
        imgvw.contentMode = .scaleAspectFill
        imgvw.translatesAutoresizingMaskIntoConstraints = false
        return imgvw
    }()
    
    private let nameTextField = CustomTextField(fieldType: "Name",givenInput: "Jon Snow")
    private let userNameTextField = CustomTextField(fieldType: "Username", givenInput: "chosen_one")
    private let phoneNumberTextField = CustomTextField(fieldType: "Number", givenInput: "8 777 567 89 43")

    private lazy var changeProfilePictureButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Profile Picture", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "DevHouse IOS"
        presenter.input = self
        nameTextField.delegate = self
        userNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        view.backgroundColor = .white
        addSubviews()
        output.loadUserData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false // important
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addSubviews() {
        view.addSubview(nameTextField)
        view.addSubview(userNameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(profileImageView)
        view.addSubview(changeProfilePictureButton)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant:20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            userNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant:20),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant:20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            changeProfilePictureButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant:20),
            changeProfilePictureButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            changeProfilePictureButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
            
        ])
    }
    
    @objc func didTap() {
        output.getRandomImage()
    }
    
}

extension ViewController: ProfileViewInput {
    func updateImage(image: UIImage) {
        profileImageView.image = image
        
    }
    
    func updateFields(name: String, username: String, phone: String) {
        nameTextField.setText(text: name)
        userNameTextField.setText(text: username)
        phoneNumberTextField.setText(text: phone)
    }
}

extension ViewController: CustomTextFieldDelegate {
    func saveTextForField(text: String, field: String) {
        output.saveUserData(text: text, field: field)
    }
}
