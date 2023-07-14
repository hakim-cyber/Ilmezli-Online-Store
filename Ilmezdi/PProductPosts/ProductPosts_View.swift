//
//  ProductPosts_View.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import SwiftUI

struct ProductPosts_View: View {
    @ObservedObject var vm:ProductPosts_ViewModel
    @State private var screen = UIScreen.main.bounds.size
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
            ZStack{
               
                VStack{
                    VStack{
                        if vm.images == []{
                                Color.gray.opacity(0.05)
                                .frame(width: 150, height:  (210) * 0.55 )
                                .overlay{
                                    Text("No Image")
                                    }
                                .cornerRadius(10)
                                                    
                            }else{
                            vm.images.first!
                               .resizable()
                               .scaledToFit()
                               .frame(width: 150, height:  (210) * 0.55 )
                               .background( Color.gray.opacity(0.05))
                               .cornerRadius(10)
                        }
                    }
                    
                    
                    VStack(spacing:5){
                        HStack{
                            Text(vm.product.category)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        HStack{
                            Text(vm.product.name)
                                .font(.system(size: 15))
                                .foregroundColor(colorScheme == .dark ? .white :.black)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        HStack{
                           
                            Text("\(vm.product.price.formatted()) ₼")
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                            Spacer()
                        }
                      
                        Spacer()
                    }
                    .padding(.top,5)
                    .padding(.horizontal,7)
                    .frame(width: 150, height:  (210) * 0.45 )
                   
                }
                .cornerRadius(7)
            
                
                
            }
            
            .frame(width: 150, height:  210)
            
       
        
        
        
    }
}

struct ProductPosts_View_Previews: PreviewProvider {
    
   
    @State static var example =  Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 ")
    
    static var previews: some View {
       var vm = ProductPosts_ViewModel(product: $example)
        ProductPosts_View(vm:  vm)
    }
}
