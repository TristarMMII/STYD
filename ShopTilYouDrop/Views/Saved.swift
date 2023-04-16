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
    
    @State var wishlistItems = [WishListItem]()

    
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
                        
                        let wishlistItem = WishListItem(id: 0, productId: productId, productTitle: productTitle, productDescription: productDescription, productPhotos: productPhotos, productRating: productRating, typicalPriceRange: typicalPriceRange)
                        
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


struct ProductDetail: View {
    
    let product: WishListItem
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack {
                HStack {
                    
                    Text(product.productTitle )
                        .padding()
                        .font(.largeTitle)
                    
        
                    .cornerRadius(10)
                    
                    
                }
                
                .onTapGesture {
                    
                }
                    
                    Spacer(minLength: 10)
                }
                
                Divider()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(product.productPhotos , id: \.self) { imageURLString in
                            AsyncImage(url: URL(string: imageURLString)!)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    
                    
                    HStack(spacing: 50){
                        Text(String(format: "%.1f", product.productRating))
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        
                    }
                    .padding()
                    
                    HStack(spacing: 50){
                        Text("Typical Price Range: \(product.typicalPriceRange[0] ) - \(product.typicalPriceRange[1] )")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        
                    }
                    .padding()
                    
                    
                    HStack{
                        
                    
                }
                    
                    Text(product.productDescription )
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    
                    Spacer()
                    
                            .padding(.vertical, 10)
                        
                    
                    }
                }
    }
    }


struct Saved_Previews: PreviewProvider {
    static var previews: some View {
        Saved()
    }
}
