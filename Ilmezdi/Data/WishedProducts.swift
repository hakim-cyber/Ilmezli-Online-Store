//
//  WishedProducts.swift
//  Ilmezdi
//
//  Created by aplle on 7/14/23.
//

import Foundation

@MainActor
class WishedProducts:ObservableObject{
    @Published var wishedProducts:[String] = []
    let key = "wishedProducts"
    init(){
        loadWished()
    }
    func checkWish(product:Product)->Bool{
        if wishedProducts.contains(where: {$0 == product.id}){
            return true
        }else{
            return false
        }
    }
    func tapedToHeart(product:Product){
        if checkWish(product: product){
            if let id = wishedProducts.firstIndex(where: {$0 == product.id}){
                wishedProducts.remove(at: id)
              
            }
        }else{
            wishedProducts.append(product.id)
            
        }
        saveWished()
    }
    func saveWished(){
        if let encoded = try? JSONEncoder().encode(wishedProducts){
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    func loadWished(){
        if let data = UserDefaults.standard.object(forKey: key){
            if let decoded = try? JSONDecoder().decode([String].self, from: data as! Data){
                self.wishedProducts = decoded
            }
        }
    }
    
    
    
}
