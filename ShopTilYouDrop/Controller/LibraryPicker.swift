//
//  LibraryPicker.swift
//  ShopTilYouDrop
//
//  Created by Nichoalas Cammisuli on 2023-04-09.
//
import SwiftUI
import PhotosUI

struct LibraryPicker : UIViewControllerRepresentable{
    @Binding var selectedImage : UIImage?
    @Binding var isPresented : Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<LibraryPicker>) -> some UIViewController{
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> LibraryPicker.Coordinator{
        return Coordinator(parent: self)
    }
    
    class Coordinator : PHPickerViewControllerDelegate{
        
        var parent : LibraryPicker
        
        init(parent: LibraryPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            if results.count != 1{
                return
            }
            
            if let image = results.first{
                if image.itemProvider.canLoadObject(ofClass: UIImage.self){
                    image.itemProvider.loadObject(ofClass: UIImage.self){image, error in
                        guard error == nil else{
                            print(#function, "Cannot obtain UIIMage type \(error)")
                            return
                        }
                        if let myImage = image {
                            let identifiers = results.compactMap(\.assetIdentifier)
                            let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
                            let imageMetaData = fetchResults[0]
                            
                            print(#function, "creation date : \(imageMetaData.creationDate!)")
                            print(#function, "fav images : \(imageMetaData.isFavorite)")
                            
                            self.parent.selectedImage = image as? UIImage
                        }
                    }
                }
            }//if let image = result.first ends
            
            self.parent.isPresented.toggle()
        }
    }
    
}

