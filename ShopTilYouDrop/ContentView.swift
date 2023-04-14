import SwiftUI


struct ContentView: View {
    
    @State private var maxWidth: CGFloat = .zero
    @State private var selection: Int? = nil
    
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {

        NavigationView {
            
            VStack{
                
                NavigationLink(destination: Login(classifier: classifier), tag: 1, selection: self.$selection){}

                NavigationLink(destination: Register(classifier: classifier), tag: 2, selection: self.$selection){}
                
                Spacer()
                
                Image("Image")
                    .resizable()
                    .frame(width: 350, height: 350)
                
                Spacer()
                
                Button(action: {
                    self.selection = 1
                    
                }){
                    //appearance
                    Text("LOGIN")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .frame(width: 300)
                        .frame(height: 80)
                        .background(Color.blue)
                }//Sign In Button ends
                .background(Color.indigo)
                .cornerRadius(20)
                .padding(.bottom, 20)
                
                
                
                
                Button(action: {
                    self.selection = 2
                }){
                    //appearance
                    Text("REGISTER")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .frame(width: 300)
                        .frame(height: 80)
                        .background(Color.blue)
                }//Sign In Button ends
                .background(Color.indigo)
                .cornerRadius(20)
                
                
                
            
                
            }.padding(.bottom, 75) //vstack
            
        }//nav stack
        .navigationBarBackButtonHidden()
        
      
        
    }
    
}

private func rectReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { gp -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = max(binding.wrappedValue, gp.frame(in: .local).width)
            }
            return Color.clear
        }
    }

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
