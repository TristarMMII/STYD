//
//  Saved.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-12.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct Saved: View {
    
   @State var items : [String] = []
    
    func fetchItems() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User is not signed in.")
            return
        }
        
        Firestore.firestore().collection("UserData").getDocuments { snapshot, error in
               if let documents = snapshot?.documents {
                   self.items = []
                   for document in documents {
                       let documentId = document.documentID
                       if documentId == userId, let items = document.data()["Wishlist"] as? [String] {
                           self.items += items
                       }
                   }
               } else if let error = error {
                   print("Error fetching documents: \(error.localizedDescription)")
               }
           }
       }
    

    
    var body: some View {
        
        VStack{
            
            HStack{

                Text("Wishlist")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                
                Image(systemName: "heart.fill")
                    .font(.title2)
                
            }
            
            List (items, id: \.self) { item in
                    HStack{
                        Image(systemName: "iphone.gen3")
                        Text("\(item) ")
                        Spacer()
                        Image(systemName: "heart.fill")
                    }
                }
            
            
            .onAppear(){
                fetchItems()
            }
            
            
        }
        
    }
}

struct Saved_Previews: PreviewProvider {
    static var previews: some View {
        Saved()
    }
}
