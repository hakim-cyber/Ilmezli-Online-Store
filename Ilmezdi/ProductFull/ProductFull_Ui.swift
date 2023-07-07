//
//  ProductFull_Ui.swift
//  Ilmezdi
//
//  Created by aplle on 7/7/23.
//

import SwiftUI

struct ProductFull_Ui: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var productData:ProductsData
    @ObservedObject var vm:ProductFull_ViewModel
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack{
                
            }
        }
    }
}

struct ProductFull_Ui_Previews: PreviewProvider {
    @State static var example =  Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 ")
    static var previews: some View {
        ProductFull_Ui(vm: ProductFull_ViewModel(product: $example))
            .environmentObject(ProductsData())
    }
}
