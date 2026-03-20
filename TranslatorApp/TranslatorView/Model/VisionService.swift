//
//  VisionService.swift
//  TranslatorApp
//
//  Created by Nurtore on 21.03.2026.
//

//
//  VisionService.swift
//  TranslatorApp
//

import UIKit
import Vision

class VisionService {
    
    func recognizeText(from image: UIImage, completion: @escaping (String?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }
        
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition error: \(String(describing: error))")
                completion(nil)
                return
            }
            
            // Combine all recognized text lines into a single string
            let recognizedText = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }.joined(separator: " ")
            
            completion(recognizedText)
        }
        
        request.recognitionLevel = .accurate
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Perform the heavy lifting on a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                print("Failed to perform text recognition: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
