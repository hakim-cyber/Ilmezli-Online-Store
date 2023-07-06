//
//  ProductsGrid.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import SwiftUI

struct ProductsGrid: View {
     @StateObject var vm = ProductsGrid_ViewModel()
    let columns = [
            GridItem(.adaptive(minimum: 180))
        ]

    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVGrid(columns: columns){
                ForEach(vm.exampleProducts.indices,id:\.self){id in
                    ProductPosts_View(vm: ProductPosts_ViewModel(product:$vm.exampleProducts[id]))
                }
            }
            .padding(.top)
        }
    }
}

struct ProductsGrid_Previews: PreviewProvider {
    static var previews: some View {
        ProductsGrid()
    }
}
