//
//  User.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-30.
//

import Foundation
import SwiftUI


struct ListItems: Identifiable {
    var id: Int
    var productId: String
    var productTitle: String
    var productDescription: String
    var productPhotos: [String]
    var productRating: Double
    var typicalPriceRange: [String]
}

struct ProductDetail: View {
    
    let product: ListItems
    
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

class User: Identifiable{
    
    var wishList: String = ""
    var history: String = ""
    
    
    init(wishList: String, history: String){
        self.wishList = wishList
        self.history = history
    }
    
}

