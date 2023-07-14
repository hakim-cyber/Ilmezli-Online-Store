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
            
            guard let provider = results.first?.itemProvider else{return}
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){ image, _ in
                    if let uimage = image as? UIImage{
                        self.parent.imagesArray.append(uimage)
                    }
                }
            }
        }
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
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

struct ImagePicker2:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
  
}