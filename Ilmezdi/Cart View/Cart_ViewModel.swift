//
//  Cart_ViewModel.swift
//  Ilmezdi
//
//  Created by aplle on 7/10/23.
//

import SwiftUI

class Cart_ViewModel:ObservableObject{
    @Published var cartProducts:[Product] = [Product(id: UUID().uuidString, name: "Ventilyator", description: "", images: ["image"], category: "Ev", price: 15.5, postDate: ""),Product(id: UUID().uuidString, name: "Ventilyator 2", description: "", images: ["image2"], category: "Ev", price: 15.5, postDate: ""),Product(id: UUID().uuidString, name: "Ventilyator 3 ", description: "", images: ["image3"], category: "Ev", price: 15.5, postDate: ""),
                                             Product(id: UUID().uuidString, name: "Ventilyator 4", description: "", images: ["image4"], category: "Ev", price: 15.5, postDate: "")]
    
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
}
