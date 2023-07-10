//
//  Cart_ViewModel.swift
//  Ilmezdi
//
//  Created by aplle on 7/10/23.
//

import SwiftUI

class Cart_ViewModel:ObservableObject{
    @Published var cartProducts:[Product] = []
    
    func addProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.id == product.id}){
            cartProducts[id].count += 1
        }else{
            cartProducts.append(product)
        }
    }
    func decreaseProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.id == product.id}){
            if cartProducts[id].count > 1{
                cartProducts[id].count -= 1
            }
        }
    }
    func deleteProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.id == product.id}){
           
            cartProducts.remove(at: id)
        }
    }
    func useImage(text:String)->Image{
           let data = Data(base64Encoded: text) ?? Data()
           
           let uiImage = UIImage(data: data) ?? UIImage()
           
           return Image(uiImage: uiImage)
       }
    var totalPrice:Double{
        var totalPrice = 0.0
        
        for product in cartProducts {
            let totalofProduct = Double(product.count) * product.price
            
            totalPrice += totalofProduct
        }
        return totalPrice
        
    }
}
