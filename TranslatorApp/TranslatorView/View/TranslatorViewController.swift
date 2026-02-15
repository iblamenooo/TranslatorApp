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
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputBox.delegate = self
        outputBox.delegate = self
        presenter.input = self
        tableView.dataSource = self
        tableView.delegate = self
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
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            inputBox.widthAnchor.constraint(equalToConstant: 364),
            inputBox.heightAnchor.constraint(equalToConstant: 200),
            
            outputBox.widthAnchor.constraint(equalToConstant: 364),
            outputBox.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

extension TranslatorViewController: CustomInputBoxDelegate {
    func didTapFavorite() {
        output.addToFavorites()
    }
    func sourceLanguage(language: String) {
        output.changeSourceLanguage(language: language)
    }
    func saveTextForField(text: String) {
        output.inputTextDidChange(text)
    }
}

extension TranslatorViewController: CustomOutputBoxDelegate {
    func languageDidChange(language: String) {
        output.changeTranslationLanguage(language: language)
    }
}

extension TranslatorViewController: TranslatorViewInput {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showTranslation(_ text: String) {
        outputBox.updateTranslatedText(text)
    }
}

extension TranslatorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.getFavoriteCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomCell.identifier,
            for: indexPath
        ) as? CustomCell else {
            fatalError("Could not dequeue CustomCell")
        }
        
        let item = output.getFavorite(index: indexPath.row)
        cell.showText(original: item.originalText,translated: item.translatedText)
        cell.showLanguages(sourceLanguage: item.sourceLang, targetedLanguage: item.targetedLang)
        
        return cell
    }
}

extension TranslatorViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = output.getFavorite(index: indexPath.row)

        inputBox.updateOriginalText(item.originalText)
        inputBox.updateSourceLanguage(item.sourceLang)
        outputBox.updateTranslatedText(item.translatedText)
        outputBox.updateTranslatedLanguage(item.targetedLang)

//        // optional: deselect animation
//        tableView.deselectRow(at: indexPath, animated: true)
    }
}




//custimtableview cell: is done, button to return text to box is done, return language also is partly done but with some bugs that can only changed by enum
