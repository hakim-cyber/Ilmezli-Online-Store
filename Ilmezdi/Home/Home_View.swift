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
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing:20){
               
                    HStack(spacing:20){
                        SearchBar(text: $vm.searchText)
                        
                        Cart_(font: 22, itemCount: 4)
                        
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 22))
                    }
                if vm.selectedCategory == nil{
                    Categories_Bar(selectedCategory: $vm.selectedCategory)
                }
                    
                    VStack{
                        ProductsGrid()
                        
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
    }
}
