//
//  Update.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-04-13.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Update: View {
    
    @State var email: String = Auth.auth().currentUser?.email ?? ""
    @State var password: String = ""
    @State private var selection: Int? = nil
    @State private var userLoggedIn = false
    @State private var showingAlert = false
    @State private var msg = ""
    
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        
        VStack(spacing: 30){
            
            
            NavigationLink(destination: Homepage(classifier: classifier), tag: 2, selection: self.$selection){}
            
            
            Spacer()
            
            Text("UPDATE")
                .fontWeight(.bold)
                .font(Font.system(size: 50))
                .foregroundColor(Color.blue)
                .padding(.bottom, 100)
            
            
            // Form
            VStack(spacing: 25){
                TextField("Email", text: $email)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5).frame(width: 320, height: 45))
                    .multilineTextAlignment(.center)
                
                VStack(spacing:10){
                    SecureField("Password", text: $password)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5).frame(width: 320, height: 45))
                        .multilineTextAlignment(.center)
                    
                }
            }
            
           
            Button(action: {
                updateEmail(newEmail: email)
                updatePassword(newPassword: password)
            }){
                Text("Update Information")
                    .modifier(CustomTextM(fontName: "MavenPro-Bold", fontSize: 16, fontColor: Color.white))
                
                    .frame(maxWidth: .infinity)
                    .frame(width: 320,height: 56, alignment: .leading)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert(self.msg, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            
            Spacer()
            
                .padding(.horizontal,30)
                .padding(.vertical, 25)
                .onAppear {
                    Auth.auth().addStateDidChangeListener{auth, user in
                        if user != nil {
                            userLoggedIn.toggle()
                        }
                    }
                }
            
        }
    }
    
    func updateEmail(newEmail: String) {
       guard let currentUser = Auth.auth().currentUser else { return }
       currentUser.updateEmail(to: newEmail) { error in
           if let error = error {
               print("Error updating email: \(error.localizedDescription)")
           } else {
               print("Email updated successfully!")
           }
       }
    }
    
    func updatePassword(newPassword: String) {
       guard let currentUser = Auth.auth().currentUser else { return }
       currentUser.updatePassword(to: newPassword) { error in
           if let error = error {
               print("Error updating password: \(error.localizedDescription)")
           } else {
               print("Password updated successfully!")
           }
       }
    }
    
}



struct Update_Previews: PreviewProvider {
    static var previews: some View {
        Update(classifier: ImageClassifier.init())
    }
}
