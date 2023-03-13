//
//  Saved.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-12.
//

import SwiftUI

struct Saved: View {
    
    let items = [
            "Nintendo Switch",
            "PS5",
            "Xbox Series X",
            "Samsung Galaxy S21",
            "Ring Doorbell",
            "Roomba",
            "Sony PlayStation VR",
            "Honeywell Thermostat",
            "Fitbit Charge",
            "Bose Headphones",
            "Nest Hello Doorbell"
        ]
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                
                Text("Wishlist")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                
                Image(systemName: "heart.fill")
                    .font(.title2)
                
            }
            
            List {
                ForEach(items, id: \.self) { item in
                    HStack{
                        Image(systemName: "iphone.gen3")
                        Text("\(item) ")
                        Spacer()
                        Image(systemName: "heart.fill")
                    }
                }
            }
            
            
        }
        
    }
}

struct Saved_Previews: PreviewProvider {
    static var previews: some View {
        Saved()
    }
}
