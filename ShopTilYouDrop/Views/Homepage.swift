//
//  Homepage.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-10.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        
        NavigationView {
            
            TabView {
                
                VStack (spacing: 75){

                    
                    Text("Scan or select a photo")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .underline()
                    
                    Image("photo")
                        .resizable()
                        .frame(width: 175, height: 175)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                                .padding(-50)
                        )
                    
                    
                    
                    Button(action: {
                        
                    }){
                        Text("SCAN")
                            .modifier(CustomTextM(fontName: "MavenPro-Bold", fontSize: 16, fontColor: Color.white))
                        
                            .frame(maxWidth: 280)
                            .frame(height: 56, alignment: .leading)
                            .background(Color.blue)
                            .cornerRadius(7)
                    }
                    
                    HStack {
                        
                        Image("photo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("Select Photo")
                        
                    }.onTapGesture {
                        
                    }.padding(-50)
                    
                }.offset(y: 20)
                
                    .tabItem {
                        Image(systemName: "camera.fill")
                        Text("Scan")
                
                    }
                
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                Text("Saved")
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Saved")
                    }
            }
            
            
        }
        .navigationTitle("Shop Till You Drop")
                    .navigationBarItems(trailing:
                        NavigationLink(destination: Settings()) {
                            Image(systemName: "gearshape.fill")
                        }
                    )
                    .navigationBarItems(leading:
                        NavigationLink(destination: Homepage()) {
                            Image(systemName: "person.crop.circle.fill")
                        }
                    )
                    .navigationBarBackButtonHidden(true)
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
