//
//  CameraHelper.swift
//  ShopTilYouDrop
//
//  Created by Nichoalas Cammisuli on 2023-04-13.
//

import Foundation

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
        }else if let deviceDual = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back){
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
