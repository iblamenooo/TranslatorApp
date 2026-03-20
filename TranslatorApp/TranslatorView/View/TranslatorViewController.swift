//
//  TranslatorViewController.swift
//  TranslatorApp
//
//  Created by Nurtore on 11.01.2026.

import UIKit
import Vision

class TranslatorViewController: UIViewController {
    private let presenter = TranslatorViewPresenter()
    
    private lazy var output:TranslatorViewOutput = presenter
    
    private let inputBox = CustomInputBox()
    private let outputBox = CustomOutputBox()
    private let visionService = VisionService()
    
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
        tap.cancelsTouchesInView = false
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
    func sourceLanguage(language: Language) {
        output.changeSourceLanguage(language: language)
    }
    func saveTextForField(text: String) {
        output.inputTextDidChange(text)
    }
    func didTapScanPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
}

extension TranslatorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }

        visionService.recognizeText(from: image) { [weak self] recognizedText in
            guard let self = self, let text = recognizedText, !text.isEmpty else { return }

            DispatchQueue.main.async {
                self.inputBox.updateOriginalText(text)
                self.output.inputTextDidChange(text)
            }
        }
    }
}

extension TranslatorViewController: CustomOutputBoxDelegate {
    func languageDidChange(language: Language) {
        output.changeTranslationLanguage(language: language)
    }
}

extension TranslatorViewController: TranslatorViewInput {

    func updateFavoriteButton(isFavorite: Bool) {
        inputBox.updateFavoriteButton(isFavorite: isFavorite)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showTranslation(_ text: String) {
        outputBox.updateTranslatedText(text)
    }
}



extension TranslatorViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = output.getFavorite(index: indexPath.row)
        
        output.didSelectFavorite(item)

        inputBox.updateOriginalText(item.originalText)
        inputBox.updateSourceLanguage(item.sourceLang)
            
        outputBox.updateTranslatedText(item.translatedText)
        outputBox.updateTranslatedLanguage(item.targetedLang)

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            
            self.output.deleteFavorite(at: indexPath.row)
            completion(true)
        }
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


