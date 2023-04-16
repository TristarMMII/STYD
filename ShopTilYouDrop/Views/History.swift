//
//  History.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-04-16.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct History: View {
    
    @State var history = [ListItems]()
    @State private var showingAlert = false
    @State private var msg = ""
    let fireDBHelper = FireDBHelper()
    @State var product : Product.Datum
    
    func fetchHistoryData(){
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User is not signed in.")
            return
        }
        
        Firestore.firestore().collection("UserData").document(userId).getDocument { snapshot, error in
            if let documentData = snapshot?.data(), let wishlist = documentData["History"] as? [[String: Any]] {
                
                for item in wishlist {
                    let productId = item["product_id"] as? String ?? ""
                    let productTitle = item["product_title"] as? String ?? ""
                    let productDescription = item["product_description"] as? String ?? ""
                    let productPhotos = item["product_photos"] as? [String] ?? []
                    let productRating = item["product_rating"] as? Double ?? 0.0
                    let typicalPriceRange = item["typical_price_range"] as? [String] ?? []
                    
                    let historyItem = ListItems(id: 0, productId: productId, productTitle: productTitle, productDescription: productDescription, productPhotos: productPhotos, productRating: productRating, typicalPriceRange: typicalPriceRange)
                    
                    if !self.history.contains(where: { $0.productId == historyItem.productId }) {
                        self.history.append(historyItem)
                    }
                }
                
            } else if let error = error {
                print("Error fetching wishlist data: \(error.localizedDescription)")
            }
        }
    }
    
    func wipeHistory(){
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User is not signed in.")
            return
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("UserData").document(userId)
        
        docRef.updateData(["History": FieldValue.delete()]) { error in
            if let error = error {
                print("Error deleting items from History: \(error.localizedDescription)")
            } else {
                print("Items deleted successfully from History")
            }
        }
        
        
    }
    
    var body: some View {
        
        
        VStack{
                    
            HStack{
               
                Text("History")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                
                Image(systemName: "list.clipboard.fill")
                    .font(.title2)
                
                VStack {
                    
                    Button(action : {
                        wipeHistory()
                        showingAlert = true
                        msg = "History deleted successfully!"
                    }) {
                        Image(systemName: "trash.fill")
                        
                    }
                    Text("Delete All")
                }.padding(.leading, 50)
                
                .alert(self.msg, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            } .padding(.leading, 80)
            
        }


            
            HStack{
                
                List {
                    ForEach(history, id: \.productId) { item in
                        VStack(alignment: .leading) {
                            NavigationLink(destination: ProductDetail(product: item)) {
                                Text(item.productTitle)
                            }
                        }
                        
                    }
                    
                    
                }
                .onAppear {
                    fetchHistoryData()
                }
                
            } .refreshable {
                fetchHistoryData()
            }
        }
    }
    
    

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History(product: Product.Datum(product_id: "", product_title: "Product Title", product_description: "Product description goes here. This is a sample text to show how it can be formatted.", product_photos: ["https://via.placeholder.com/150", "https://via.placeholder.com/150", "https://via.placeholder.com/150"], product_rating: 0, product_page_url: "", product_offers_page_url: "", product_specs_page_url: "", product_reviews_page_url: "", product_num_reviews: 0, typical_price_range: ["$200", "$300"], offer: Product.Offer(store_name: "Store Name", store_rating: 0, offer_page_url: "", store_review_count: 0, store_reviews_page_url: "", price: "", shipping: "", tax: "", on_sale: false, product_condition: "")))
    }
}
