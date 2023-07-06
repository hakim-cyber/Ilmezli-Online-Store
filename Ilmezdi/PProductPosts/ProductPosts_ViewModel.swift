//
//  ProductPosts_ViewModel.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import Foundation
import SwiftUI



class ProductPosts_ViewModel:ObservableObject{
   
   @Binding var product:Product
    
    init(product: Binding<Product>) {
        self._product = product
    }
    
    var images:[Image]{
        let strings = product.images
        
        var images:[Image] = []
        
        if strings == []{
            return images
        }else{
            for string in strings {
                images.append(useImage(text: string))
            }
            return images
        }
    }
    func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()

        // Convert Date to String
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func useImage(text:String)->Image{
           let data = Data(base64Encoded: text) ?? Data()
           
           let uiImage = UIImage(data: data) ?? UIImage()
           
           return Image(uiImage: uiImage)
       }
    func stringToDate(string:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let reverseDate = dateFormatter.date(from: string)
        return reverseDate ?? Date.now
       
    }
   
}
