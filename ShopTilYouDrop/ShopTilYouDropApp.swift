//
//  ShopTilYouDropApp.swift
//  ShopTilYouDrop
//
//  Created by Nichoalas Cammisuli on 2023-03-08.
//

import Firebase
import FirebaseFirestore
import SwiftUI


@main
struct ShopTilYouDropApp: App {
    
    let fireDBHelper = FireDBHelper()
    let productDataQuery = ProductQueryController()
    let classifier = ImageClassifier()
    
    init() {
        FirebaseApp.configure()
//        fireDBHelper = FireDBHelper(database: Firestore.firestore())
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: classifier).environmentObject(fireDBHelper).environmentObject(productDataQuery).environmentObject(classifier)
        }
    }
}
