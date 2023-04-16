//
//  Homepage.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-10.
//

import SwiftUI

struct Homepage: View {
    
    @State private var isShowingMenu = false
    @State private var menuWidth: CGFloat = 0
    
    @ObservedObject var classifier: ImageClassifier
    @State private var selection: Int? = nil
    
    
    var body: some View {
        
        NavigationLink(destination: History(product: Product.Datum(product_id: "", product_title: "Product Title", product_description: "Product description goes here. This is a sample text to show how it can be formatted.", product_photos: ["https://via.placeholder.com/150", "https://via.placeholder.com/150", "https://via.placeholder.com/150"], product_rating: 0, product_page_url: "", product_offers_page_url: "", product_specs_page_url: "", product_reviews_page_url: "", product_num_reviews: 0, typical_price_range: ["$200", "$300"], offer: Product.Offer(store_name: "Store Name", store_rating: 0, offer_page_url: "", store_review_count: 0, store_reviews_page_url: "", price: "", shipping: "", tax: "", on_sale: false, product_condition: ""))), tag: 1, selection: self.$selection){}
        
        NavigationView {
            
            
            ZStack(alignment: .leading) {

                Color.white
                
                TabView() {
                    
                    Scan()
                        .tabItem {
                            Image(systemName: "camera.fill")
                            Text("Scan")
                            
                        }
                    
                    Search(productList: [])
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    
                    Saved()
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("Wishlist")
                            
                        }
                    
                        
                    
                }

                if isShowingMenu {
                    
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    VStack(alignment: .leading) {
                        
                        Button(action: {
                            self.selection = 1
                            
                        }) {
                            HStack {
                                Image(systemName: "list.clipboard.fill")
                                    .foregroundColor(.red)
                                Text("History")
                            }
                        }
                        .padding(.top)

                        Button(action: {
                            // Perform an action when the button is tapped
                            print("Menu Item 2 Tapped")
                        }) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("Menu Item 2")
                            }
                        }
                        .padding(.top, 20)

                        Button(action: {
                            // Perform an action when the button is tapped
                            print("Menu Item 3 Tapped")
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.blue)
                                Text("Menu Item 3")
                            }
                        }
                        .padding(.top, 20)

                        Spacer()
                        
      
                        
                    }
                    .frame(width: menuWidth)
                    .background(Color.white)
                    .transition(.move(edge: .leading))
                }

            }
            
            
        }
        
                    .navigationBarItems(trailing:
                        NavigationLink(destination: Settings(classifier: classifier)) {
                            Image(systemName: "gearshape.fill")
                        }
                    )
        
                    .navigationBarItems(leading:
                        Button(action: {
                            withAnimation {
                                isShowingMenu.toggle()
                                   
                                
                            }
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                        }
                    )
                    .onAppear {
                        menuWidth = UIScreen.main.bounds.width / 1.75
                    }
                    .navigationBarBackButtonHidden(true)
    }
}

//struct Homepage_Previews: PreviewProvider {
//    static var previews: some View {
//        Homepage()
//    }
//}
