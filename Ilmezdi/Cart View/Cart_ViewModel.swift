//
//  Cart_ViewModel.swift
//  Ilmezdi
//
//  Created by aplle on 7/10/23.
//

import SwiftUI

@MainActor
class Cart_ViewModel:ObservableObject{
    @Published var cartProducts:[CartItem] = []
    
    
    func addProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.product.id == product.id}){
            cartProducts[id].count += 1
        }else{
            let cartItem = CartItem(id: UUID(), product: product)
            cartProducts.append(cartItem)
        }
    }
    func decreaseProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.product.id == product.id}){
            cartProducts[id].count -= 1
        }
    }
    func deleteProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.product.id == product.id}){
           
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
            let totalofProduct = product.product.price * Double(product.count)
            
            totalPrice += totalofProduct
        }
        return totalPrice
        
    }
}
