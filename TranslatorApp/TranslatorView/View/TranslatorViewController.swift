//
//  TranslatorViewController.swift
//  TranslatorApp
//
//  Created by Nurtore on 11.01.2026.

import UIKit

class TranslatorViewController: UIViewController{
    
    private let presenter = TranslatorViewPresenter()
    
    private lazy var output:TranslatorViewOutput = presenter
    
    private let inputBox = CustomInputBox()
    private let outputBox = CustomOutputBox()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputBox.delegate = self
        navigationItem.title = "DevHouse IOS"
        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false // important
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func setupUI() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(inputBox)
        stackView.addArrangedSubview(outputBox)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            inputBox.widthAnchor.constraint(equalToConstant: 364),
            inputBox.heightAnchor.constraint(equalToConstant: 200),

            outputBox.widthAnchor.constraint(equalToConstant: 364),
            outputBox.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension TranslatorViewController: CustomInputBoxDelegate {
    func bookmarkButtonTapped() {
        output.bookmarkTapped()
    }
    
    func saveTextForField(text: String) {
        outputBox.updateText(text)
    }
}
