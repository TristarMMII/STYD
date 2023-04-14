//
//  ProductCompair.swift
//  ShopTilYouDrop
//
//  Created by Jordan Bhar on 2023-03-12.
//

import SwiftUI

import SwiftUI

struct ProductCompair: View {
    let productName: String
    let productIndex: Int
    @EnvironmentObject var productHelper: ProductQueryController
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(productName)")
                        .font(.largeTitle)
                        .bold()
                }
                Divider()
            }
            
            Spacer()
            
            HStack(spacing: 150) {
                VStack(spacing: 10) {
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
            
            VStack {
                if let productData = productHelper.productData[safe: productIndex]?.data {
                    List {
                        ForEach(productData, id: \.product_id) { data in
                            NavigationLink(
                                destination: ProductsDetailPage(product: data)
                            ) {
                                Text(data.product_title ?? "No Data")
                                Spacer()
                                Spacer()
                                Text("\(data.typical_price_range?[0] ?? "$0.0") - \(data.typical_price_range?[1] ?? "$0.0")")
                                //since this is the comparison page show the price range and let the user then go into the details page to show the entire details of the product they might be interested in
                            }
                        }
                    }
                } else {
                    Text("No data available")
                }
            }
        }
    }
}

struct ProductCompair_Previews: PreviewProvider {
    static var previews: some View {
        ProductCompair(productName: "", productIndex: 0)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

