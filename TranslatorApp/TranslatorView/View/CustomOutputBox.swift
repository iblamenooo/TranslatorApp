//
//  CustomOutputBox.swift
//  TranslatorApp
//
//  Created by Nurtore on 22.01.2026.
//

import UIKit

protocol CustomOutputBoxDelegate:AnyObject {
    func languageDidChange(language:Language)
}

class CustomOutputBox: UIView {
    weak var delegate: CustomOutputBoxDelegate?
    
    private let outputTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = .black
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 20, weight: .regular)
        tv.textAlignment = .left
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Russian (Russia)"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var btnMenu: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsMenuAsPrimaryAction = true
        return btn
    }()
    
    private func configureMenu() {
        let actions = Language.allCases.map { lang in
            UIAction(title: lang.title) { [weak self] _ in
                self?.languageLabel.text = lang.title
                // Передаем объект enum напрямую в делегат
                self?.delegate?.languageDidChange(language: lang)
            }
        }
        btnMenu.menu = UIMenu(title: "Languages", children: actions)
    }
    
    
    init() {
        super.init(frame: .zero)
        setupUI()
        configureMenu()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTranslatedText(_ text: String) {
        outputTextView.text = text
    }
    func updateTranslatedLanguage(_ language:Language) {
        languageLabel.text = language.title
    }
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 20
        clipsToBounds = true
        addSubview(languageLabel)
        addSubview(outputTextView)
        addSubview(btnMenu)
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            languageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            btnMenu.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: 8),
            btnMenu.centerYAnchor.constraint(equalTo: languageLabel.centerYAnchor),

            outputTextView.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20),
            outputTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            outputTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            outputTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}


