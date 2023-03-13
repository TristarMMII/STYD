//
//  Settings.swift
//  ShopTilYouDrop
//
//  Created by Nichoalas Cammisuli on 2023-03-12.
//

import SwiftUI

struct Settings: View {
    @State private var notiOn = true
    
    var body: some View {
        VStack{
            
            VStack{
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .foregroundColor(Color.blue)
                    .frame(width: 100.0, height: 100.0)
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                
            }//Vstack
            .padding(.top, 50.0)
            
            List{
                Section(header: Text("Notifications")){
                    Toggle("Turn on notifications", isOn: $notiOn)
                        .font(.title2)
                }//section
                .font(.title2)
            }
                
            Button(action:{
                
            }){
               Text("Rate The App")
                    .bold()
                    .padding(.horizontal, 35.0)
                    .foregroundColor(Color.white)
                    .frame(minWidth: 300, minHeight: 80)
                    .font(.system(size:30))
                    .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color.blue))
            }//Rate app button
            
            Button(action:{
                
            }){
               Text("Sign Out")
                    .bold()
                    .padding(.horizontal, 35.0)
                    .foregroundColor(Color.white)
                    .frame(minWidth: 300, minHeight: 80)
                    .font(.system(size:30))
                    .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color.blue))
            }//sign out button
            
            
            Spacer()
            Spacer()
        }//vstack
    }//body
}//main view

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
