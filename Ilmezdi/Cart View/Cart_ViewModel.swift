//
//  Cart_ViewModel.swift
//  Ilmezdi
//
//  Created by aplle on 7/10/23.
//

import Foundation

class Cart_ViewModel:ObservableObject{
    @Published var cartProducts:[Product] = []
    
    func addProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.id == product.id}){
            cartProducts[id].count += 1
        }else{
            cartProducts.append(product)
        }
    }
    func deleteProduct(product:Product){
        if let id = cartProducts.firstIndex(where: {$0.id == product.id}){
            if cartProducts[id].count > 1{
                cartProducts[id].count -= 1
            }else{
                cartProducts.remove(at: id)
            }
        }
    }
}
