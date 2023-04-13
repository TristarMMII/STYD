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
        VStack {
            HStack {
                Text(product.product_title ?? "No Data")
                    .font(.largeTitle)
                    .bold()
            }
            Divider()
        }
        Text(String(product.product_rating ?? 0))
        Text(product.product_description ?? "No Data")
            
//        AsyncImage(url: URL(string: "\(product.product_photos?[0] ?? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled.png")"))

        
    }
}

struct ProductsDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductsDetailPage(product: Product.Datum(product_id: "", product_title: "", product_description: "", product_photos: [""], product_rating: 0.0, product_page_url: "", product_offers_page_url: "", product_specs_page_url: "", product_reviews_page_url: "", product_num_reviews: 0, typical_price_range: [""], offer: Product.Offer(store_name: "", store_rating: 0.0, offer_page_url: "", store_review_count: 0, store_reviews_page_url: "", price: "", shipping: "", tax: "", on_sale: false, product_condition: "")))
    }
}
