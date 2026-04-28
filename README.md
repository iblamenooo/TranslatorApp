# TranslatorApp

TranslatorApp is an iOS application for real-time text translation between multiple languages.  
The app allows users to translate text instantly, save favorite translations, and manage them locally.






https://github.com/user-attachments/assets/48efe6b6-e55c-4dde-a4e0-a0d70db53394







## Features

- Real-time text translation
- Support for multiple languages
- Clean UIKit-based interface
- MVP architecture
- Favorite translations storage
- Offline access to saved translations
- Profile/settings screen
- Local data persistence with Core Data
- Lightweight user preferences with UserDefaults

## Tech Stack

- Swift
- UIKit
- MVP
- Core Data
- UserDefaults
- URLSession
- Google Translate API

## Architecture

The project uses the **MVP (Model-View-Presenter)** architecture.

This helps separate responsibilities:

- **View** — displays UI and handles user interactions
- **Presenter** — contains presentation logic and communicates between View and Model
- **Model** — handles data, API responses, and persistence

## Main Screens

### Translation Screen

Users can enter text and receive translation in real time.

### Favorites Screen

Users can save important translations and access them later.

### Profile Screen

Users can manage basic preferences and app settings.

## What I Learned

While building this project, I improved my skills in:

- Building UI programmatically with UIKit
- Working with MVP architecture
- Making network requests using URLSession
- Parsing API responses
- Saving data locally with Core Data
- Managing app state and user preferences
- Structuring code for maintainability

## Installation

1. Clone the repository:

```bash
git clone https://github.com/iblamenooo/TranslatorApp.git
