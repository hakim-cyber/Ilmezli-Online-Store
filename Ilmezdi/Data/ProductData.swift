//
//  ProductData.swift
//  Ilmezdi
//
//  Created by aplle on 7/7/23.
//

import SwiftUI


class ProductsData:ObservableObject{
    @Published var exampleProducts:[Product] = [Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 "),Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 "),Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 "),Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 "),Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 "),Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 "),Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 ")]
    
    @Published var categories = [ Category(title: "Hamısı", image: "square.stack.3d.up.fill"),
        Category(title: "Ev", image: "house.lodge.circle"),Category(title: "Mətbəx", image: "fork.knife"),Category(title: "Texnika", image: "desktopcomputer"),Category(title: "Tikinti", image: "building.2.crop.circle"),Category(title: "Xirdavat", image: "light.ribbon"),
    ]
    
    
    // boolean to show cartView
    @Published var showCartView = false
    
    func useImage(text:String)->Image{
           let data = Data(base64Encoded: text) ?? Data()
           
           let uiImage = UIImage(data: data) ?? UIImage()
           
           return Image(uiImage: uiImage)
       }
    func deleteProduct(product:Product){
        if let id = exampleProducts.firstIndex(where: {$0.id == product.id}){
           
            exampleProducts.remove(at: id)
        }
    }
    func addProduct(product:Product){
       
            exampleProducts.append(product)
        
    }
}
