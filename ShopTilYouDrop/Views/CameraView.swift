//
//  CameraView.swift
//  ShopTilYouDrop
//
//  Created by Nichoalas Cammisuli on 2023-03-23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        ZStack{
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                
                Spacer()
                
                HStack{
                    
                    if camera.isTaken{
                        
                        Button(action: {if !camera.isSaved{camera.SaveOutput()}}, label: {
                            Text(camera.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        
                        HStack{
                            Spacer()
                            
                            Button(action: camera.RetakePicture, label: {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                                
                            })
                            .padding(.trailing)
                        }//HSTACK
                        
                        Spacer()
                        
                        
                    }else{
                        Button(action: camera.TakePicture, label: {
                            
                            ZStack{
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 70, height: 70)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 80, height: 80)
                            }//zstack
                        })
                    }
                }//hstack
                .frame(height: 80)
                
            }//vstack
        }//zstack
        .onAppear(perform: {
            camera.CheckPermissions()
        })
    }//body
}//view

//Camera model
class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output = AVCapturePhotoOutput()
    
    //preview
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    //picture data
    @Published var isSaved = false
    
    @Published var  picData = Data(count: 0)
    
    func CheckPermissions(){
        //check permissions
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            //make session
            SetUp()
            return
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){(status) in
                if status{
                    self.SetUp()
                }
            }
            
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
        }
    }
    
    func SetUp(){
        //set up camera
        //        do{
        //setting congifs
        self.session.beginConfiguration()
        
        //depends on device (.builtindualcamera has multiple options depending on the iphone model)
        if let device = AVCaptureDevice.default(.builtInTripleCamera, for: .video, position: .back){
            do{
                let input = try AVCaptureDeviceInput(device: device)
                
                //check and add to session
                if self.session.canAddInput(input){
                    self.session.addInput(input)
                }
                
                //output
                if self.session.canAddOutput(self.output){
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
            }
            catch {
                print("error")
            }
        }
        else if let deviceDual = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back){
            do{
                let input = try AVCaptureDeviceInput(device: deviceDual)
                
                //check and add to session
                if self.session.canAddInput(input){
                    self.session.addInput(input)
                }
                
                //output
                if self.session.canAddOutput(self.output){
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
            }
            catch {
                print("error")
            }
        }else {
            print("camera not available")
        }
        
        
        
        
        
        //    }catch{
        //        print(error.localizedDescription)
        //    }
    }
    
    //take and retake
    func TakePicture(){
        DispatchQueue.global(qos: .background).async{
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation{
                    self.isTaken.toggle()
                }
            }
        }
    }
    
    func RetakePicture(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{
                    self.isTaken.toggle()
                }
                
                //clear
                self.isSaved = false
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil{
            return
        }
        print("Picture Taken")
        
        guard let imageData = photo.fileDataRepresentation() else{return}
        
        self.picData = imageData
    }
    
    func SaveOutput(){
        if let image = UIImage(data: self.picData){
            //save image
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            self.isSaved = true
            
            print("Save Successful")
        }
        
        
        
        
    }
}

//setting view for preview
struct CameraPreview: UIViewRepresentable{
    
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        //set proper.
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        //start sesion
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
