//
//  ProductsDetailPage.swift
//  ShopTilYouDrop
//
//  Created by Jordan Bhar on 2023-04-12.
//

import SwiftUI

struct ProductsDetailPage: View {
    
    var product : Product.Datum
    
    var body: some View {
        ScrollView(.vertical){
            VStack {
                HStack {
                    Text(product.product_title ?? "No Data")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer(minLength: 10)
                }
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(product.product_photos ?? ["https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled.png"], id: \.self) { imageURLString in
                            AsyncImage(url: URL(string: imageURLString)!)
                                .frame(width: 150, height: 150)
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(String(format: "%.1f", product.product_rating ?? 0))
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text(product.product_description ?? "No Data")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Typical Price Range: \(product.typical_price_range?[0] ?? "") - \(product.typical_price_range?[1] ?? "")")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // Handle button action here
                        }) {
                            Text("Buy Now")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                .padding(.horizontal, 20)
            }
        }
        }
}

struct ProductsDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductsDetailPage(product: Product.Datum(product_id: "", product_title: "Product Title", product_description: "Product description goes here. This is a sample text to show how it can be formatted.", product_photos: ["https://via.placeholder.com/150", "https://via.placeholder.com/150", "https://via.placeholder.com/150"], product_rating: 4.5, product_page_url: "", product_offers_page_url: "", product_specs_page_url: "", product_reviews_page_url: "", product_num_reviews: 0, typical_price_range: ["$200", "$300"], offer: Product.Offer(store_name: "Store Name", store_rating: 4.5, offer_page_url: "", store_review_count: 0, store_reviews_page_url: "", price: "", shipping: "", tax: "", on_sale: false, product_condition: "")))
    }
}
