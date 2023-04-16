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
        
        let productData: [String: Any] = [
                "product_id": product.product_id ?? "",
                "product_title": product.product_title ?? "",
                "product_description": product.product_description ?? "",
                "product_photos": product.product_photos ?? [],
                "product_rating": product.product_rating ?? 0,
                "typical_price_range": product.typical_price_range ?? [],
                "offer": [
                "store_name": product.offer.store_name,
                "product_condition": product.offer.product_condition ?? "",
                "store_reviews_page_url": product.offer.store_reviews_page_url ?? "",
                "offer_page_url": product.offer.offer_page_url ?? "",
            ]
                ]
        data.updateData(["Wishlist": FieldValue.arrayUnion([productData])]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    
    
    
    
}

