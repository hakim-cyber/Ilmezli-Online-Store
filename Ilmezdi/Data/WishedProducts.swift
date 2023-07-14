//
//  WishedProducts.swift
//  Ilmezdi
//
//  Created by aplle on 7/14/23.
//

import Foundation

@MainActor
class WishedProducts:ObservableObject{
    @Published var wishedProducts:[Product] = []
    
    func checkWish(product:Product)->Bool{
        if wishedProducts.contains(where: {$0.id == product.id}){
            return true
        }else{
            return false
        }
    }
    
    
    
}
