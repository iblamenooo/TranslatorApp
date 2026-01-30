//
//  CustomInputBox.swift
//  TranslatorApp
//
//  Created by Nurtore on 22.01.2026.
//
import UIKit

protocol CustomInputBoxDelegate: AnyObject {
    func saveTextForField(text: String)
    func sourceLanguage(language:String)
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
    
  let engAction = UIAction(title: "English (USA)") { _ in
        print("English tapped")
    }
    let rusAction = UIAction(title: "Russian (Russia)") { _ in
        print("Russian tapped")
    }
    let franceAction = UIAction(title: "France (France)") { _ in
        print("France tapped")
    }

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
        return button
    }()
    
    private func configureMenu() {
        let engAction = UIAction(title: "English (USA)") { [weak self] _ in
            self?.languageLabel.text = "English (USA)"
            print("English tapped")
            self?.delegate?.sourceLanguage(language: "English (USA)")
        }
        
        let rusAction = UIAction(title: "Russian (Russia)") { [weak self] _ in
            self?.languageLabel.text = "Russian (Russia)"
            print("Russian tapped")
            self?.delegate?.sourceLanguage(language: "Russian (Russia)")
        }
        
        let franceAction = UIAction(title: "France (France)") { [weak self] _ in
            self?.languageLabel.text = "France (France)"
            print("France tapped")
            self?.delegate?.sourceLanguage(language: "France (France)")
        }
        btnMenu.menu = UIMenu(title: "Languages", children: [engAction, rusAction, franceAction])
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

