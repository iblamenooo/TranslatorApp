//
//  CustomOutputBox.swift
//  TranslatorApp
//
//  Created by Nurtore on 22.01.2026.
//

import UIKit

class CustomOutputBox: UIView {
    private let outputTextView: UITextView = {
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
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateText(_ text: String) {
        outputTextView.text = text
    }
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 20
        clipsToBounds = true
        addSubview(languageLabel)
        addSubview(outputTextView)
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            languageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),

            outputTextView.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20),
            outputTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            outputTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            outputTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
