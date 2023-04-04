//
//  Scan.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-12.
//

import SwiftUI


struct Scan: View {
    
    @State private var selection: Int? = nil
    
    var body: some View {
        
        
        VStack (spacing: 75){

            Text("Shop Till You Drop")
                .font(.title2)
                .fontWeight(.bold)
            
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
            
            
            NavigationLink(destination: CameraView(), tag: 1, selection: self.$selection){}
            
            
            Button(action: {
                selection = 1
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
            
        }.offset(y: 0)
    }
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        Scan()
    }
}
