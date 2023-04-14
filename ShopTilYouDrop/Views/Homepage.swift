//
//  Homepage.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-10.
//

import SwiftUI

struct Homepage: View {
    
    @State private var isShowingMenu = false
    @State private var menuWidth: CGFloat = 0
    
    @ObservedObject var classifier: ImageClassifier
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .leading) {

                Color.white
                
                TabView() {
                    
                    Scan(classifier: classifier)
                        .tabItem {
                            Image(systemName: "camera.fill")
                            Text("Scan")
                            
                        }
                    
                    Search(productList: [])
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

                if isShowingMenu {
                    
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)

                    VStack(alignment: .leading) {
                        
                        
                        Button(action: {
                            // Perform an action when the button is tapped
                            print("Menu Item 1 Tapped")
                        }) {
                            HStack {
                                Image(systemName: "list.clipboard.fill")
                                    .foregroundColor(.red)
                                Text("Menu Item 1")
                            }
                        }
                        .padding(.top)

                        Button(action: {
                            // Perform an action when the button is tapped
                            print("Menu Item 2 Tapped")
                        }) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("Menu Item 2")
                            }
                        }
                        .padding(.top, 20)

                        Button(action: {
                            // Perform an action when the button is tapped
                            print("Menu Item 3 Tapped")
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.blue)
                                Text("Menu Item 3")
                            }
                        }
                        .padding(.top, 20)

                        Spacer()
                        
                        Button(action: {
                            // Perform an action when the button is tapped
                            print("Menu Item 3 Tapped")
                        }) {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.blue)
                                Text("Update Information")
                            }
                        }
                        .padding(.top, 20)
                        
                    }
                    .frame(width: menuWidth)
                    .background(Color.white)
                    .transition(.move(edge: .leading))
                }

            }
            
            
        }
        
                    .navigationBarItems(trailing:
                        NavigationLink(destination: Settings(classifier: classifier)) {
                            Image(systemName: "gearshape.fill")
                        }
                    )
        
                    .navigationBarItems(leading:
                        Button(action: {
                            withAnimation {
                                isShowingMenu.toggle()
                                   
                                
                            }
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                        }
                    )
                    .onAppear {
                        menuWidth = UIScreen.main.bounds.width / 1.75
                    }
                    .navigationBarBackButtonHidden(true)
    }
}

//struct Homepage_Previews: PreviewProvider {
//    static var previews: some View {
//        Homepage()
//    }
//}
