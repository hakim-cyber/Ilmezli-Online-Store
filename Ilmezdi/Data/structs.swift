//
//  structs.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import Foundation

struct Product:Identifiable{
    let id:String
    
    let name:String
    let description:String
    
    let images:[String]
    
    let category:String
    var price:Double
    
    var postDate:String
    var IsWished = false
    
    var count = 1
}

struct Category{
    let title:String
    let image:String
}
