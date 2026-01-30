//
//  CustomOutputBox.swift
//  TranslatorApp
//
//  Created by Nurtore on 22.01.2026.
//

import UIKit

protocol CustomOutputBoxDelegate:AnyObject {
    func languageDidChange(language:String)
}

class CustomOutputBox: UIView {
    weak var delegate: CustomOutputBoxDelegate?
    
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
    
  let engAction = UIAction(title: "English (USA)") { _ in
        print("English tapped")
      
    }
    let rusAction = UIAction(title: "Russian (Russia)") { _ in
        print("Russian tapped")
        
    }
    let franceAction = UIAction(title: "France (France)") { _ in
        print("France tapped")
        
    }
    
    private func configureMenu() {
        let engAction = UIAction(title: "English (USA)") { [weak self] _ in
            self?.languageLabel.text = "English (USA)"
            print("English tapped")
            self?.delegate?.languageDidChange(language: "English (USA)")
        }
        
        let rusAction = UIAction(title: "Russian (Russia)") { [weak self] _ in
            self?.languageLabel.text = "Russian (Russia)"
            print("Russian tapped")
            self?.delegate?.languageDidChange(language: "Russian (Russia)")
        }
        
        let franceAction = UIAction(title: "France (France)") { [weak self] _ in
            self?.languageLabel.text = "France (France)"
            print("France tapped")
            self?.delegate?.languageDidChange(language: "France (France)")
        }
        btnMenu.menu = UIMenu(title: "Languages", children: [engAction, rusAction, franceAction])
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        configureMenu()
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


