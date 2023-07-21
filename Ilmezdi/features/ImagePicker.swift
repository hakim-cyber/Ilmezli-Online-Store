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
                
                
                
                DispatchQueue.main.async {
                    if provider.canLoadObject(ofClass: UIImage.self){
                        
                        provider.loadObject(ofClass: UIImage.self){ image, error in
                            if error != nil{
                                print(error)
                                return
                            }
                            if let uimage = image as? UIImage{
                                self.parent.imagesArray.append(uimage)
                            }else{
                                print("No uimage")
                            }
                        }
                    }else{
                        print("cant load object")
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


