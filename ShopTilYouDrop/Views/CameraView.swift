//
//  CameraView.swift
//  ShopTilYouDrop
//
//  Created by Nichoalas Cammisuli on 2023-03-23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    @ObservedObject var classifier: ImageClassifier
    
    @StateObject var camera = CameraModel()
    @State public var selection: Int? = nil
    @State private var showingAlert = false
    
    
    var body: some View {
        ZStack{
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                
                NavigationLink(destination: Scan(classifier: classifier), tag: 1, selection: self.$selection){}
                
                Spacer()
                
                HStack{
                    
                    if camera.isTaken{
                        
                        
                        Button(action: {if !camera.isSaved{camera.SaveOutput()}
                            if camera.isSaved{
                                showingAlert = true
                                selection = 1
                            }
                            
                        }, label: {
                            Text(camera.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        .alert("Photo Saved Successfully", isPresented: $showingAlert) {
                                    Button("OK", role: .cancel) { }
                                }
                        
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

//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
