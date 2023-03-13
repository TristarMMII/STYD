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
            
            TabView() {
                
                Scan()
                    .tabItem {
                        Image(systemName: "camera.fill")
                        Text("Scan")
                        
                    }
                
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                Saved()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Saved")
                        
                    }
                
                    
                
            }
            
            
        }
        .navigationTitle("Shop Till You Drop")
                    .navigationBarItems(trailing:
                        NavigationLink(destination: Homepage()) {
                            Image(systemName: "gear")
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
