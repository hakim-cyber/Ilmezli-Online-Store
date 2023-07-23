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
        config.selectionLimit = 3 - imagesArray.count
        
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


