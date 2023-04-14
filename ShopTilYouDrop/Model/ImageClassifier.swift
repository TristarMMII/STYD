//
//  ImageClassifier.swift
//  ShopTilYouDrop
//
//  Created by Nichoalas Cammisuli on 2023-04-14.
//

import Foundation
import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        classifier.results
    }
        
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
        
    }
        
}
