//
//  ProductCompair.swift
//  ShopTilYouDrop
//
//  Created by Jordan Bhar on 2023-03-12.
//

import SwiftUI

struct ProductCompair: View {
    @State private var productList = ["Walmart","Amazon","Canada Computers","Best Buy","Apple","Amazon","Amazon","Amazon","Amazon","Amazon",]
    @State private var selection : Int? = nil
    @State private var selectedIndex : Int = -1
    
    var body: some View {
        VStack{
            
            VStack{
                HStack{
                    Text("Product Name")
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
                    ForEach (productList.enumerated().map({$0}), id: \.element.self){index , currentProduct in
                        VStack{
                            
                            
                            HStack{
                                VStack(spacing: 5){
                                    Text(currentProduct)
                                        .font(.headline)
                                        
                                    Text("Price : $0.00")
                                    Text("Stock : 1 qty")
                                }

                                
                                Spacer()
                                
                                Button(action : {
        
                                }){
                                    Text("Checkout")
                                        .foregroundColor(.white)
                                        .padding(10)
                                }
                                .background(Color.blue)
                                .cornerRadius(10)
                            
                            }
                            
                        }
                    }
                }
            }
            
        }
    }
}

struct ProductCompair_Previews: PreviewProvider {
    static var previews: some View {
        ProductCompair()
    }
}