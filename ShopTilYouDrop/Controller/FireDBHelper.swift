//
//  FireDBHelper.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-30.
//

import Foundation
import Firebase
import FirebaseAuth

class FireDBHelper: ObservableObject {
    
    init(){}
    
    
    func setUserData(userData: User){
        
        let db = Firestore.firestore()
        let data = db.collection("UserData").document(Auth.auth().currentUser!.uid)
        data.updateData(["Wishlist" : userData.wishList]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func addWishlistData(product: Product.Datum){
        let db = Firestore.firestore()
        let data = db.collection("UserData").document(Auth.auth().currentUser!.uid)
        data.updateData(["Wishlist": FieldValue.arrayUnion([product.product_title!])]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}

