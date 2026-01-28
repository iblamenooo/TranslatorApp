//
//  CustomTextField.swift
//  TranslatorApp
//
//  Created by Nurtore on 25.12.2025.
//

import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func saveTextForField(text: String, field: String)
}

class CustomTextField: UIView {
    weak var delegate: CustomTextFieldDelegate? // = ViewController
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField:UITextField = {
        let field = UITextField()
        field.textColor = .systemGray
        field.font = .systemFont(ofSize: 20, weight: .regular)
        field.placeholder = "Your Data"
        field.textAlignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init (fieldType:String,givenInput:String) {
        super.init(frame: .zero)
        label.text = fieldType
        textField.placeholder = givenInput
        textField.delegate = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        addSubview(stackView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant:20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setText(text:String) {
        textField.text = text
    }
    
}

extension CustomTextField:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.saveTextForField(text: textField.text ?? "", field: label.text ?? "")
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
