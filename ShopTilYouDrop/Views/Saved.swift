//
//  Saved.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-12.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct WishListItem: Identifiable {
    var id: Int
    var productId: String
    var productTitle: String
    var productDescription: String
    var productPhotos: [String]
    var productRating: Double
    var typicalPriceRange: [String]
}


struct Saved: View {
    
    @State var items : [String] = []
    @State var wishlistItems = [WishListItem]()
    @State private var hasAppeared = false
    
//    func fetchItems() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("Error: User is not signed in.")
//            return
//        }
//
//        Firestore.firestore().collection("UserData").getDocuments { snapshot, error in
//               if let documents = snapshot?.documents {
//                   self.items = []
//                   for document in documents {
//                       let documentId = document.documentID
//                       if documentId == userId, let items = document.data()["Wishlist"] as? [String] {
//                           self.items += items
//                       }
//                   }
//               } else if let error = error {
//                   print("Error fetching documents: \(error.localizedDescription)")
//               }
//           }
//       }
    
    func fetchWishlistData() {
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
                    
                    // Do something with the data, e.g. add it to an array
                    let wishlistItem = WishListItem(id: 5, productId: productId, productTitle: productTitle, productDescription: productDescription, productPhotos: productPhotos, productRating: productRating, typicalPriceRange: typicalPriceRange)
                    self.wishlistItems.append(wishlistItem)
                }
            
            } else if let error = error {
                print("Error fetching wishlist data: \(error.localizedDescription)")
            }
        }
    }

    
    func removeItems(at offsets: IndexSet) {
        self.items.remove(atOffsets: offsets)
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User is not signed in.")
            return
        }
        
        let data = ["Wishlist": self.items]
        Firestore.firestore().collection("UserData").document(userId).setData(data, merge: true) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
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
                    }
                        
                .onAppear {
                    if !hasAppeared {
                    fetchWishlistData()
                    hasAppeared = true
                }
                    
                }
        }
        
    }
}

struct ProductDetail: View {
    
    let product: WishListItem
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack {
                HStack {
                    Text(product.productTitle ?? "No Data")
                        .padding()
                        .font(.largeTitle)
                }
            }
        }
    }
    }


struct Saved_Previews: PreviewProvider {
    static var previews: some View {
        Saved()
    }
}
