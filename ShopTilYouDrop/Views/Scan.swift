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
    
    @State private var profileImage : UIImage?
    @State private var permissionGranted : Bool = false
    @State private var showSheet : Bool = false
    @State private var showPicker : Bool = false
    @State private var isUsingCamera : Bool = false
    
//    private var coordinator: Coordinator? = nil
    
    var body: some View {
        
        
        
        VStack{
            
            NavigationLink(destination: CameraView(), tag: 1, selection: self.$selection){}

            Text("Shop Till You Drop")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, -10)
            
            
            Text("Scan or select a photo")
                .fontWeight(.bold)
                .font(.largeTitle)
                .underline()
                .padding(.top, 55)
            
            Image(uiImage: (profileImage ?? UIImage(systemName: "photo"))!)
                    .resizable()
                    .frame(width: 315, height: 315)
//                    .overlay(
//                        Rectangle()
//                            .stroke(Color.black, lineWidth: 2)
//                            .padding(-50)
//                    )
            
            Button(action: {
                if(self.permissionGranted){
                    self.showSheet = true
                }else{
                    self.requestPermissions()
                }
            }){
                Text("Upload Picture")
            }
            .actionSheet(isPresented: $showSheet){
                ActionSheet(title: Text("Select Photo"),
                message: Text("Choose photo to upload"),
                buttons: [
                    .default(Text("Choose from Photo Library")){
                        // when user want to pick pic from the library
                        self.showPicker = true
                    },
                    .default(Text("Take a new pic from camera")){
                        // when user want to open camera and click new pic
                        selection = 1
                        guard UIImagePickerController.isSourceTypeAvailable(.camera)
                        else{
                            print(#function, "Camera is not available")
                            return
                        }
                        
                        print(#function, "Camera is available")
                        //camera is available, open the  camera to allow taking pic
                        self.isUsingCamera = true
                        self.showPicker = true
                    },
                    .cancel()
                ]
                            
                )//action sheet
            }//.actionsheet
            .padding(.top, 35)
            .padding(.bottom, 55)
            
            
            Button(action: {
                print("DO ML KIT")
            }){
                Text("SCAN")
                    .modifier(CustomTextM(fontName: "MavenPro-Bold", fontSize: 16, fontColor: Color.white))
                
                    .frame(maxWidth: 280)
                    .frame(height: 56, alignment: .leading)
                    .background(Color.blue)
                    .cornerRadius(7)
            }//button
            
            Spacer()
            
        }//vstack
        .offset(y: 0)
            .fullScreenCover(isPresented: $showPicker){
                if(isUsingCamera){
                    //show camera selction
                }else{
                    //open photoLibrary
                    LibraryPicker(selectedImage: self.$profileImage, isPresented: self.$showPicker)
                }
            }
            .onAppear(){
                checkPermissions()
            }//.onAppear
    }
    
    private func checkPermissions(){
        switch PHPhotoLibrary.authorizationStatus(){
        case .authorized:
            self.permissionGranted = true
        case .denied, .notDetermined, .restricted, .limited:
            self.requestPermissions()
        @unknown default:
            break
        }
    }
    
    private func requestPermissions(){
        PHPhotoLibrary.requestAuthorization{status in
            switch status{
            case .authorized:
                self.permissionGranted = false
                
            case .denied, .notDetermined:
                return
                
            case .restricted:
                return
            case .limited:
                return
            @unknown default:
                return
            }
        }
    }
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        Scan()
    }
}
