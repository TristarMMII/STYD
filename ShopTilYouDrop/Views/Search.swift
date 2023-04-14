//
//  Search.swift
//  ShopTilYouDrop
//
//  Created by Jordan Bhar on 2023-03-12.
//

import SwiftUI


import SwiftUI

struct Search: View {
    
    @State var productList : [String]
    @State var searchProduct : String = ""
    @State private var selection : Int? = nil
    @State private var selectedProduct : String = ""
    @State private var product : [Product] = [Product]()
    @State private var isLoading = false
    @State private var showingAlert = false
    @State private var currentIndex = 0
    @EnvironmentObject var productHelper : ProductQueryController

    
    var body: some View {
        NavigationView{
            VStack{
                
                NavigationLink(destination: ProductCompair(productName: selectedProduct, productIndex: currentIndex ), tag : 1, selection: self.$selection ){}
            
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
                            isLoading = true
                            productList.append(searchProduct)
                            //maybe create a external function that will wait for the data to be gathered
                            
                            
                            

                            productHelper.fetchProductData(for: searchProduct) { result in
                                switch result {
                                case .success(let product):
                                    print("Received product data: \(product)")
                                    self.isLoading = false
                                case .failure(let error):
                                    print("Error fetching product data: \(error)")
                                    productList.removeLast()
                                    self.isLoading = false
                                    showingAlert = true
                                    
                                }
                            }
                            
                        }){
                            Text("Search")
                                .foregroundColor(.white)
                                .padding(10)
                        }
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                    }

                    Divider()
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("To Many Queries"), message: Text("Please Wait a Few Miniutes Before Searching Again"), dismissButton: .default(Text("Dismiss")))
                }
                
                List{
                    if(!productList.isEmpty){
                        ForEach (productList.enumerated().map({$0}), id: \.element.self){index , currentProduct in
                            VStack{
                                
                                
                                HStack{
                                    Text(currentProduct)
                                        .bold()
                                    
                                    Spacer().lineLimit(5)
                                    
                                    Button(action : {}){ Image(systemName: "heart").font(.largeTitle).foregroundColor(Color.white)}
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        
                                    }
                                    
                                    Button(action : {}){ Image(systemName: "trash").font(.largeTitle).foregroundColor(Color.white)}
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        
                                        productHelper.removeProduct(at: index) { result in
                                            switch result {
                                            case .success:
                                                print("Product removed successfully")
                                                self.productList.remove(at: index)
                                                //need to fix this method, its removing products, but not the correct one, simple fix just gotta figure out where the sillyness is coming from
                                            case .failure(let error):
                                                print("Error removing product: \(error)")
                                                self.productList.remove(at: index)
                                            }
                                        }
                                    }
                                    
                                    
                                    Button(action: {}, label: {
                                        if isLoading {
                                            ProgressView()
                                                .padding(10)
                                                .foregroundColor(.white)
                                        } else {
                                            Text("Compare")
                                                .padding(10)
                                                .foregroundColor(.white)
                                        }
                                    })
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .disabled(isLoading)
                                    .onTapGesture {
                                        if !isLoading {
                                            self.selectedProduct = currentProduct
                                            self.currentIndex = index
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
}

//struct Search: View {
//
//    @State var productList : [String]
//    @State var searchProduct : String = ""
//    @State private var selection : Int? = nil
//    @State private var selectedProduct : String = ""
//    @State private var product : Product = Product()
//
//    @EnvironmentObject var productHelper : ProductQueryController
//
//
//    var body: some View {
//        NavigationView{
//            VStack{
//
//                NavigationLink(destination: ProductCompair(_productName: selectedProduct , productObject : product ), tag : 1, selection: self.$selection ){}
//
//                VStack{
//                    HStack{
//                        Text("Product Search")
//                            .font(.largeTitle)
//                            .bold()
//                        Image(systemName: "magnifyingglass")
//                            .font(.title2)
//                    }
//                }
//
//                Group{
//
//                    HStack{
//
//                        Button(action:{
//
//                        }){
//                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
//                                .font(.title)
//                        }
//
//                        TextField("Enter Product", text: $searchProduct)
//                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 16)
//                                        .stroke(.blue, lineWidth: 3)
//
//                                )
//                            .frame(width:  UIScreen.main.bounds.width - 150)
//                            .disableAutocorrection(true)
//                            .textInputAutocapitalization(.words)
//
//                        Button(action:{
//                            productList.append(searchProduct)
//                            //maybe create a external function that will wait for the data to be gathered
//                            self.productHelper.fetchProductData(for: searchProduct, completion: { result in
//                                switch result {
//                                                case .success(let product):
//                                                    print("Fetched product: \(product)")
//                                                case .failure(let error):
//                                                    print("Error fetching product: \(error)")
//                                                }
//                            })
//                        }){
//                            Text("Search")
//                                .foregroundColor(.white)
//                                .padding(10)
//                        }
//                        .background(Color.blue)
//                        .cornerRadius(10)
//
//                    }
//
//                    Divider()
//                }
//
//                List{
//                    if(!productList.isEmpty){
//                        ForEach (productList.enumerated().map({$0}), id: \.element.self){index , currentProduct in
//                            VStack{
//
//
//                                HStack{
//                                    Text(currentProduct)
//                                        .bold()
//
//                                    Spacer().lineLimit(5)
//
//                                    Button(action : {}){ Image(systemName: "trash").font(.largeTitle).foregroundColor(Color.white)}
//                                    .background(Color.red)
//                                    .cornerRadius(10)
//                                    .onTapGesture {
//                                        self.productList.remove(at: index)
//                                        self.productHelper.productData.remove(at: index)
//                                    }
//
//
//                                    Button(action: {}, label: {Text("Compare")
//                                            .foregroundColor(.white)
//                                            .padding(10)})
//                                        .background(Color.blue)
//                                        .cornerRadius(10)
//                                        .onTapGesture {
//                                        self.selectedProduct = currentProduct
//                                        self.product = self.productHelper.getSpecificProductData(index: index)
//                                        self.selection = 1
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(productList: [""])
    }
}
