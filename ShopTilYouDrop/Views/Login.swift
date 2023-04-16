//
//  Login.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-10.
//



import SwiftUI
import Firebase
import FirebaseAuth

    struct Login: View {
        
        @State var email: String = "Test123@gmail.com"
        @State var password: String = "123456"
        @State private var selection: Int? = nil
        @State private var userLoggedIn = false
        @State private var showingAlert = false
        @State private var msg = ""
        
        @ObservedObject var classifier: ImageClassifier
        
        
        var body: some View {
            
                VStack(spacing: 30){
                    
                    NavigationLink(destination: Register(classifier: classifier), tag: 1, selection: self.$selection){}
                    
                    NavigationLink(destination: Homepage(classifier: classifier), tag: 2, selection: self.$selection){}

                    
                    Spacer()
                    
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .font(Font.system(size: 50))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 100)
                    
                    
                    // Form
                    VStack(spacing: 25){
                        TextField("Email", text: $email)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5).frame(height: 45))
                            .multilineTextAlignment(.center)
                        
                        VStack(spacing:10){
                            SecureField("Password", text: $password)
                                .padding(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5).frame(height: 45))
                                .multilineTextAlignment(.center)
                            
                        }
                    }
                    
                    // SignIn
                    Button(action: {
                        login()
                    }){
                        Text("Sign In")
                            .modifier(CustomTextM(fontName: "MavenPro-Bold", fontSize: 16, fontColor: Color.white))
                        
                            .frame(maxWidth: .infinity)
                            .frame(height: 56, alignment: .leading)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .alert(self.msg, isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                    
                    Spacer()
                    
                    // SignUp
                    VStack(spacing: 10){
                        Text("Don't have an account?")
                            .modifier(CustomTextM(fontName: "Oxygen-Regular", fontSize: 18, fontColor: Color.primary))
                        Button(action: {
                            self.selection = 1
                        }){
                            Text("Register")
                                .modifier(CustomTextM(fontName: "Oxygen-Bold", fontSize: 18, fontColor: Color.blue))
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
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
        
        func login(){
            Auth.auth().signIn(withEmail: email, password: password){result, error in
                if error != nil {
                    showingAlert = true
                    msg = error!.localizedDescription
                } else {
                    self.selection = 2
                }
            }
        }
        
    }
    
    
    struct Login_Previews: PreviewProvider {
        static var previews: some View {
            Login(classifier: ImageClassifier.init())
        }
    }
    

