//
//  CustomInputBox.swift
//  TranslatorApp
//
//  Created by Nurtore on 22.01.2026.
//
import UIKit

protocol CustomInputBoxDelegate: AnyObject {
    func saveTextForField(text: String)
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
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bookmark")
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        inputTextView.delegate = self
        setupUI()
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
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            languageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),

            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bookmarkButton.centerYAnchor.constraint(equalTo: languageLabel.centerYAnchor),

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

