//
//  CustomCell.swift
//  TranslatorApp
//
//  Created by Nurtore on 14.02.2026.
//

import UIKit

class CustomCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    private let translatedLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let languagesLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(translatedLabel)
        contentView.addSubview(languagesLabel)
        
        NSLayoutConstraint.activate([
            translatedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            translatedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            translatedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            translatedLabel.bottomAnchor.constraint(equalTo: languagesLabel.topAnchor, constant: -8),
            
            languagesLabel.topAnchor.constraint(equalTo: translatedLabel.bottomAnchor, constant: 8),
            languagesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            languagesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            languagesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showText(original:String,translated:String) {
        translatedLabel.text = "\(original) → \(translated)"
    }
    func showLanguages(sourceLanguage:String, targetedLanguage:String) {
        languagesLabel.text = "\(sourceLanguage) → \(targetedLanguage)"
    }
}
