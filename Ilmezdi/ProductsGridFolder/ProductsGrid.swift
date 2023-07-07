//
//  ProductsGrid.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import SwiftUI

struct ProductsGrid: View {
     @StateObject var vm = ProductsGrid_ViewModel()
    @EnvironmentObject var productsData:ProductsData
    let columns = [
            GridItem(.adaptive(minimum: 180))
        ]

    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVGrid(columns: columns){
                ForEach(productsData.exampleProducts.indices,id:\.self){id in
                    ProductPosts_View(vm: ProductPosts_ViewModel(product:$productsData.exampleProducts[id]))
                }
            }
            .padding(.top)
        }
    }
}

struct ProductsGrid_Previews: PreviewProvider {
    static var previews: some View {
        ProductsGrid()
            .environmentObject(ProductsData())
    }
}
