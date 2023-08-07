//
//  ProductsGrid.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import SwiftUI

struct ProductsGrid: View {
    var showWished:Bool = false
    @Binding var showSearch:Bool
    var selectedCategory:Category?
    var searchText:String? = ""
     @StateObject var vm = ProductsGrid_ViewModel()
    @EnvironmentObject var productsData:ProductsData
    @EnvironmentObject var wished:WishedProducts
    
    let columns = [
            GridItem(.flexible()),GridItem(.flexible())
        ]
    var filteredProducts:[Product]{
        if showWished{
            var wishedItems = [Product]()
            
            for id in wished.wishedProducts{
                if let product = productsData.exampleProducts.first(where: {$0.id == id}) {
                    wishedItems.append(product)
                }
            }
            
            
            
            return wishedItems
            
        }else{
            var products = [Product]()
           
            if !showSearch{
                products =  productsData.exampleProducts.filter{$0.images.count != 0}
                if selectedCategory == nil || selectedCategory?.title == "Hamısı"{
                    
                    
                    
                }else{
                    products =   products.filter{$0.category == selectedCategory?.title}
                    
                }
                return products
            }else{
                if searchText == ""{
                    return productsData.exampleProducts
                }else{
                    return productsData.exampleProducts.filter({$0.name.localizedCaseInsensitiveContains(searchText!.trimmingCharacters(in: .whitespacesAndNewlines))})
                }
            }
        }
    }
    @State private var selectedProduct:Product?

    var body: some View {
        if filteredProducts.isEmpty{
            if showWished{
                VStack{
                    
                    Text("❤️")
                        .font(.system(size: 50))
                    Text("Favori esyaniz yok")
                }
            }else{
                VStack{
                    
                    Text("☹️")
                        .font(.system(size: 50))
                    Text("Simdilik esya bulunamadi")
                }
            }
        }else{
            VStack{
               
                ScrollView(.vertical,showsIndicators: false){
                    if showSearch{
                        LazyVStack(spacing: 25){
                            ForEach(filteredProducts){product in
                                SearcPost(product: product){
                                    withAnimation(.easeInOut){
                                      
                                        selectedProduct = product
                                    }
                                }
                            }
                        }
                        .padding(6)
                        .padding(.horizontal,8)
                    }else{
                        LazyVGrid(columns: columns){
                            ForEach(filteredProducts){product in
                                if let id = productsData.exampleProducts.firstIndex(where: {$0.id == product.id}){
                                    ProductPosts_View(vm: ProductPosts_ViewModel(product:$productsData.exampleProducts[id]))
                                        .onTapGesture {
                                            withAnimation(.easeInOut){
                                                selectedProduct = product
                                            }
                                        }
                                }else{
                                    
                                }
                            }
                            
                        }
                        .padding(.top,showWished ? 25:6)
                        .padding(.horizontal,8)
                        
                    }
                }
            }
            
            .sheet(item: $selectedProduct, content: {product in
                if let id = productsData.exampleProducts.firstIndex(where: {$0.id == product.id}){
                    var vm = ProductFull_ViewModel(product: $productsData.exampleProducts[id])
                    ProductFull_Ui(vm: vm)
                }else{
                    VStack{
                    Text("No Product")
                    Button("Back"){
                        selectedProduct = nil
                    }
                }
                }
                
                
            })
          
        }
    }
}

struct ProductsGrid_Previews: PreviewProvider {
    static var previews: some View {
        ProductsGrid(showSearch: .constant(false), selectedCategory: nil)
            .environmentObject(ProductsData())
            .environmentObject(WishedProducts())
    }
}
