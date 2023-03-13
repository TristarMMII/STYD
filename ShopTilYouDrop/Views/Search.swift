//
//  Search.swift
//  ShopTilYouDrop
//
//  Created by Jordan Bhar on 2023-03-12.
//

import SwiftUI

struct Search: View {
    
    @State private var productList = ["test","test","test","test","test","test"]
    @State private var searchProduct : String = ""
    
    var body: some View {
        VStack{
            
            VStack{
                HStack{
                    Text("Product Search")
                        .font(.largeTitle)
                        .bold()
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }
            }
            
            Group{

                HStack{
                    TextField("Enter Product", text: $searchProduct)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                    .stroke(.blue, lineWidth: 3)
                                    
                            )
                        .frame(width:  UIScreen.main.bounds.width - 100)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.words)
                    
                    Button(action:{
                        
                    }){
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.title)
                    }
                }

                Divider()
            }
            
            List{
                ForEach (productList.enumerated().map({$0}), id: \.element.self){index , currentProduct in
                    VStack{
                        
                        
                        HStack{
                            Text(currentProduct)
                                .bold()
                            
                            Spacer()
                            
                            Button(action : {
                                
                            }){
                                Text("Compair")
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

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
