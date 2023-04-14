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
    
    init() {
        FirebaseApp.configure()
//        fireDBHelper = FireDBHelper(database: Firestore.firestore())
    }
    
    
    var body: some Scene {
        WindowGroup {
            Homepage().environmentObject(fireDBHelper).environmentObject(productDataQuery)
        }
    }
}
