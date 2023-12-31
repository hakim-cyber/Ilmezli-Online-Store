//
//  Categories_Bar.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI




struct Categories_Bar: View {
    @Binding var selectedCategory:Category?
    
    @EnvironmentObject var productsData:ProductsData
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        
            ScrollView(.horizontal,showsIndicators: false){
                LazyHStack(spacing: screen.width / 15){
                    ForEach(productsData.categories,id: \.title) { category in
                        
                        VStack(alignment: .center,spacing: 15){
                           
                                Image(systemName: "\(category.image)")
                                .font(.system(size: 15))
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial).shadow(radius: selectedCategory?.title == category.title ? 3:0  ) )
                                    .opacity(0.9)
                            
                            if selectedCategory?.title == category.title {
                                Text("\(category.title)")
                                    .font(.system(size: 17))
                                    .foregroundColor(.accentColor.opacity(0.9))
                            }else{
                                Text("\(category.title)")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray.opacity(0.9))
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){
                              
                                    self.selectedCategory = category
                                
                            }
                        }
                       
                        
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 80)
           
        
        
        
    }
}

struct Categories_Bar_Previews: PreviewProvider {
    static var previews: some View {
        Categories_Bar(selectedCategory: .constant(nil))
            .environmentObject(ProductsData())
    }
}
