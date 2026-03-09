//
//  CustomInputBox.swift
//  TranslatorApp
//
//  Created by Nurtore on 22.01.2026.
//
import UIKit

protocol CustomInputBoxDelegate: AnyObject {
    func saveTextForField(text: String)
    func sourceLanguage(language:Language)
    func didTapFavorite()
}

class CustomInputBox: UIView {
    weak var delegate: CustomInputBoxDelegate?
    
    private let inputTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = .black
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 20, weight: .regular)
        tv.textAlignment = .left
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "English (USA)"
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

    private let languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("English", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bookmark")
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return button
    }()
    
    
    private func configureMenu() {
        let actions = Language.allCases.map { lang in
            UIAction(title: lang.title) { [weak self] _ in
                self?.languageLabel.text = lang.title
                // Передаем объект enum напрямую в делегат
                self?.delegate?.sourceLanguage(language: lang)
            }
        }
        btnMenu.menu = UIMenu(title: "Languages", children: actions)
    }
    
    init() {
        super.init(frame: .zero)
        inputTextView.delegate = self
        setupUI()
        configureMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOriginalText(_ text: String) {
        inputTextView.text = text
    }
    
    func updateSourceLanguage(_ language:Language) {
        languageLabel.text = language.title
    }
    
    @objc private func favoriteTapped() {
        delegate?.didTapFavorite()

    }
    
    func updateFavoriteButton(isFavorite: Bool) {

        let imageName = isFavorite ? "bookmark.fill" : "bookmark"

        bookmarkButton.setImage(
            UIImage(systemName: imageName),
            for: .normal
        )
    }
    
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 20
        clipsToBounds = true
        addSubview(languageLabel)
        addSubview(bookmarkButton)
        addSubview(inputTextView)
        addSubview(btnMenu)
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            languageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),

            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bookmarkButton.centerYAnchor.constraint(equalTo: languageLabel.centerYAnchor),
            
            btnMenu.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: 8),
            btnMenu.centerYAnchor.constraint(equalTo: languageLabel.centerYAnchor),

            inputTextView.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor, constant: 20),
            inputTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            inputTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            inputTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

extension CustomInputBox: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.saveTextForField(text: textView.text ?? "")
    }
}




