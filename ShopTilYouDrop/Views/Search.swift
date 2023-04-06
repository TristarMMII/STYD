//
//  Search.swift
//  ShopTilYouDrop
//
//  Created by Jordan Bhar on 2023-03-12.
//

import SwiftUI

struct Search: View {
    
    @State var productList : [String]
    @State private var searchProduct : String = ""
    @State private var selection : Int? = nil
    @State private var selectedProduct : String = ""
    //@State private var selectedProductIndex = -1
    
    @EnvironmentObject var productHelper : ProductQueryController

    
    var body: some View {
        NavigationView{
            VStack{
                
                NavigationLink(destination: ProductCompair(_productName: selectedProduct /*,productSearchIndex: selectedProduct*/), tag : 1, selection: self.$selection ){}
            
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
                        
                        Button(action:{
                            
                        }){
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .font(.title)
                        }
                        
                        TextField("Enter Product", text: $searchProduct)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                        .stroke(.blue, lineWidth: 3)
                                        
                                )
                            .frame(width:  UIScreen.main.bounds.width - 150)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.words)
                        
                        Button(action:{
                            productList.append(searchProduct)
                        }){
                            Text("Search")
                                .foregroundColor(.white)
                                .padding(10)
                        }
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                    }

                    Divider()
                }
                
                List{
                    if(!productList.isEmpty){
                        ForEach (productList.enumerated().map({$0}), id: \.element.self){index , currentProduct in
                            VStack{
                                
                                
                                HStack{
                                    Text(currentProduct)
                                        .bold()
                                    
                                    Spacer().lineLimit(5)
                                    
                                    Button(action : {
                                        self.productList.remove(at: index)
                                        //self.productHelper.productDataQuery.remove(at: index)
                                        
                                    }){
                                        Image(systemName: "trash.fill")
                                            .font(.title)
                                    }
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    
                                    
                                    Button(action: {}, label: {Text("Compare")
                                            .foregroundColor(.white)
                                            .padding(10)})
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                        self.selectedProduct = currentProduct
                                        self.productHelper.fetchDataFromAPI(product: selectedProduct)
                                        //self.selectedProductIndex = index
                                        self.selection = 1
                                                        }
                                
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(productList: [""])
    }
}
