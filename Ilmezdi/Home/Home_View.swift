//
//  Home_View.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import SwiftUI

struct Home_View: View {
    @StateObject var vm = Home_ViewModel()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var cart:Cart_ViewModel
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing:20){
               
                    HStack(spacing:20){
                        SearchBar(text: $vm.searchText)
                      
                        Cart_(font: 30, itemCount: cart.cartProducts.count)
                        
                       
                    }
                    .padding(.horizontal)
                   
                
                    Categories_Bar(selectedCategory: $vm.selectedCategory)
                
                    
                    VStack{
                        ProductsGrid(selectedCategory: vm.selectedCategory,searchText: vm.searchText)
                        
                    }
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                
            
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.top)
            
        }
       
        
    }
}

struct Home_View_Previews: PreviewProvider {
    static var previews: some View {
        Home_View()
            .environmentObject(Cart_ViewModel())
    }
}
