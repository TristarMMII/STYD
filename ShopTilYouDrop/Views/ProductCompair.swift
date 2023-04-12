//
//  ProductCompair.swift
//  ShopTilYouDrop
//
//  Created by Jordan Bhar on 2023-03-12.
//

import SwiftUI

struct ProductCompair: View {
    let productName: String
    let productObject: Product
    
    @EnvironmentObject var productHelper: ProductQueryController
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("\(productName)")
                        .font(.largeTitle)
                        .bold()
                }
                Divider()
            }
            
            Spacer()
            
            HStack(spacing: 150){
                
                VStack(spacing: 10){
                    Text("Lowest Price : ")
                        .font(.title2)
                        .bold()
                    
                    Text("Highest Price : ")
                        .font(.title2)
                        .bold()
                    
                    Text("Average Price : ")
                        .font(.title2)
                        .bold()
                    
                }
                
                Image(systemName: "magnifyingglass")
                
                
            }
            
            VStack{
                List{
                    ForEach(productHelper.productData, id: \.request_id) { product in
                        ForEach(product.data, id: \.product_id) { data in
                            Text(data.product_title ?? "No Data")
                        }
                    }
                }
            }
        }
    }
}

struct ProductCompair_Previews: PreviewProvider {
    static var previews: some View {
        ProductCompair(productName: "", productObject: Product())
    }
}
