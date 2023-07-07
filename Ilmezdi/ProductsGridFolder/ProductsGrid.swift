//
//  ProductsGrid.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import SwiftUI

struct ProductsGrid: View {
    var selectedCategory:Category?
    var searchText:String? = ""
     @StateObject var vm = ProductsGrid_ViewModel()
    @EnvironmentObject var productsData:ProductsData
    
    let columns = [
            GridItem(.adaptive(minimum: 190))
        ]
    var filteredProducts:[Product]{
        var products = [Product]()
        if selectedCategory == nil || selectedCategory?.title == "Hamısı"{
           
                products =  productsData.exampleProducts
          
        }else{
            products =   productsData.exampleProducts.filter{$0.category == selectedCategory?.title}
            
        }
        if searchText == ""{
            return products
        }else{
            return products.filter({$0.description.localizedCaseInsensitiveContains(searchText!)})
        }
    }
    @State private var selectedProduct:Product?

    var body: some View {
        if filteredProducts.isEmpty{
            VStack{
                Text("☹️")
                    .font(.system(size: 50))
                Text("Simdilik esya bulunamadi")
            }
        }else{
            VStack{
               
                ScrollView(.vertical,showsIndicators: false){
                    LazyVGrid(columns: columns){
                        ForEach(filteredProducts){product in
                            if let id = productsData.exampleProducts.firstIndex(where: {$0.id == product.id}){
                                ProductPosts_View(vm: ProductPosts_ViewModel(product:$productsData.exampleProducts[id]))
                                    .onTapGesture {
                                        selectedProduct = product
                                    }
                            }else{
                                
                            }
                        }
                       
                    }
                    .padding(.top)
                }
            }
            .fullScreenCover(item: $selectedProduct, content: {_ in
                ProductFull_Ui()
                
                
            })
          
        }
    }
}

struct ProductsGrid_Previews: PreviewProvider {
    static var previews: some View {
        ProductsGrid(selectedCategory: nil)
            .environmentObject(ProductsData())
    }
}
