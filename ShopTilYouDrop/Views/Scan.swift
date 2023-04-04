//
//  Scan.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-12.
//

import SwiftUI
import Photos
import PhotosUI


struct Scan: View {
    
    @State private var selection: Int? = nil
    @State private var selectedImage: UIImage? = nil
    
//    private var coordinator: Coordinator? = nil
    
    var body: some View {
        
        
        VStack (spacing: 75){

            Text("Shop Till You Drop")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Scan or select a photo")
                .fontWeight(.bold)
                .font(.largeTitle)
                .underline()
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 175, height: 175)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 2)
                            .padding(-50)
                    )
            } else {
                Image("photo")
                    .resizable()
                    .frame(width: 175, height: 175)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 2)
                            .padding(-50)
                    )
            }
            
            
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
                
               didTapAdd()
                
                
            }.padding(-50)
            
        }.offset(y: 0)
    }
    
    func didTapAdd(){
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
//        coordinator = Coordinator(self)
        picker.delegate = Coordinator(self)
        //        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
        if let topWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) {
            topWindow.rootViewController?.present(picker, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: Scan
        
        init(_ parent: Scan) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            guard let itemProvider = results.first?.itemProvider else {
                return
            }
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self?.parent.selectedImage = image
                        }
                    }
                }
            }
        }
    }

        
        
    
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        Scan()
    }
}
