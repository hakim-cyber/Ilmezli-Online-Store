//
//  ImagePicker.swift
//  Ilmezdi
//
//  Created by aplle on 7/12/23.
//


import Foundation
import PhotosUI
import SwiftUI


struct ImagePicker:UIViewControllerRepresentable{
    @Binding var imagesArray:[UIImage?]
    let max:Int
    class Coordinator:NSObject,PHPickerViewControllerDelegate{
        
        var parent:ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for id in results.indices {
               
                let result = results[id]
                let provider = result.itemProvider
            
            
                
               
              
                    
                   
                if provider.hasItemConformingToTypeIdentifier(UTType.webP.identifier) {
                                       provider.loadDataRepresentation(forTypeIdentifier: UTType.webP.identifier) {data, err in
                                           if err != nil{
                                               print(err as Any)
                                               return
                                           }
                                           
                                         if let data = data, let img = UIImage.init(data: data) {
                                             if let uimage = img as? UIImage{
                                                 DispatchQueue.main.async {
                                                     self.parent.imagesArray.append(uimage)
                                                 }
                                             }else{
                                                 print("No uimage")
                                             }
                                         }
                                       }
                                     } else {
                                         do{
                                                                
                                            provider.loadObject(ofClass: UIImage.self){ image, error in
                                                                    if error != nil{
                                                                        print(error as Any)
                                                                        return
                                                                    }
                                                                    if let uimage = image as? UIImage{
                                                                        DispatchQueue.main.async {
                                                                            self.parent.imagesArray.append(uimage)
                                                                        }
                                                                    }else{
                                                                        print("No uimage")
                                                                    }
                                                                }
                                                            }
                                     }
                               
                   
                
            }
           
        }
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = max
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
























struct PhotoCapture: UIViewControllerRepresentable {
    
    
    
 @Binding var imagesArray: [UIImage?]
    
 @Environment(\.presentationMode)  var presentationMode
   
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoCapture>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
               imagePicker.allowsEditing = false
               imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
               
               return imagePicker
    
 
      
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoCapture>) {
 
    }
    
   
    func makeCoordinator() -> Coordinator {
           Coordinator(self)
       }
       
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
           
           var parent: PhotoCapture
           
           init(_ parent: PhotoCapture) {
               self.parent = parent
           }
           
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               
               if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                   parent.imagesArray.append(image)
               }
               
               parent.presentationMode.wrappedValue.dismiss()
           }
       }
}
