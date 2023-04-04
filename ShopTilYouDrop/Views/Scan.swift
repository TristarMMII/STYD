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
            
            if let inputImage = selectedImage {
                Image(uiImage: inputImage)
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
        
//        let picker = PHPickerViewController(configuration: config)
        
        let picker = UIImagePickerController()
        
//        coordinator = Coordinator(self)
        
//        coordinator = Coordinator(self)
//        picker.delegate = coordinator
        picker.delegate = Coordinator(self) as? any UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        //        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
        DispatchQueue.main.async {
            if let topWindow = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow }) {
                topWindow.rootViewController?.present(picker, animated: true)
            }
            }
    }
    

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: Scan
        
        init(_ parent: Scan) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true, completion: nil)
            print("TESTING")
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                        if let uiImage = info[.editedImage] as? UIImage {
                            parent.selectedImage = uiImage
                        } else if let uiImage = info[.originalImage] as? UIImage {
                            parent.selectedImage = uiImage
                            
                        }
                        picker.dismiss(animated: true)
                    }
        }

        
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true, completion: nil)
//            guard let itemProvider = results.first?.itemProvider else {
//                return
//            }
//            if itemProvider.canLoadObject(ofClass: UIImage.self) {
//                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
//                    if let image = image as? UIImage {
//                        DispatchQueue.main.async {
//                            self?.parent.selectedImage = image
//                        }
//                    }
//                }
//            }
//        }
    }

        
        
    
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        Scan()
    }
}
