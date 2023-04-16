//
//  Saved.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-12.
//

import SwiftUI
import Firebase
import FirebaseAuth



struct Saved: View {
    
    @State var wishlistItems = [ListItems]()

    
    func fetchWishlistData(){
       
            guard let userId = Auth.auth().currentUser?.uid else {
                print("Error: User is not signed in.")
                return
            }
            
            Firestore.firestore().collection("UserData").document(userId).getDocument { snapshot, error in
                if let documentData = snapshot?.data(), let wishlist = documentData["Wishlist"] as? [[String: Any]] {
                    
                    for item in wishlist {
                        let productId = item["product_id"] as? String ?? ""
                        let productTitle = item["product_title"] as? String ?? ""
                        let productDescription = item["product_description"] as? String ?? ""
                        let productPhotos = item["product_photos"] as? [String] ?? []
                        let productRating = item["product_rating"] as? Double ?? 0.0
                        let typicalPriceRange = item["typical_price_range"] as? [String] ?? []
                        
                        let wishlistItem = ListItems(id: 0, productId: productId, productTitle: productTitle, productDescription: productDescription, productPhotos: productPhotos, productRating: productRating, typicalPriceRange: typicalPriceRange)
                        
                        if !self.wishlistItems.contains(where: { $0.productId == wishlistItem.productId }) {
                            self.wishlistItems.append(wishlistItem)
                        }
                    }
                    
                } else if let error = error {
                    print("Error fetching wishlist data: \(error.localizedDescription)")
                }
            }
        }

    

    
    func removeItems(at offsets: IndexSet) {
        self.wishlistItems.remove(atOffsets: offsets)
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User is not signed in.")
            return
        }
        
        var wishlist = [[String: Any]]()
        for item in wishlistItems {
            wishlist.append([
                "product_id": item.productId,
                "product_title": item.productTitle,
                "product_description": item.productDescription,
                "product_photos": item.productPhotos,
                "product_rating": item.productRating,
                "typical_price_range": item.typicalPriceRange
            ])
        }
        
        let data = ["Wishlist": wishlist]
        Firestore.firestore().collection("UserData").document(userId).setData(data, merge: true) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document updated successfully")
            }
        }
    }

    
    var body: some View {
        
        VStack{
            
            HStack{

                Text("Wishlist")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                
                Image(systemName: "heart.fill")
                    .font(.title2)
                
            }
            
            List {
                ForEach(wishlistItems, id: \.productId) { item in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: ProductDetail(product: item)) {
                            Text(item.productTitle)
                        }
                    }
                    
                }
                
                .onDelete(perform: removeItems)
                
            }
                .onAppear {
                        fetchWishlistData()
                    }
        }
                
        }
        
    }





struct Saved_Previews: PreviewProvider {
    static var previews: some View {
        Saved()
    }
}
