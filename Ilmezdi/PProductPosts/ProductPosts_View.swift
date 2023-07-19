//
//  ProductPosts_View.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import SwiftUI

struct ProductPosts_View: View {
    @ObservedObject var vm:ProductPosts_ViewModel
    @EnvironmentObject var wished:WishedProducts
    @State private var screen = UIScreen.main.bounds.size
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
           
            ZStack{
                Color.gray.opacity(0.06)
                VStack{
                    VStack{
                        if vm.images == []{
                            Color.gray.opacity(0.05)
                                .frame(width: screen.width / 2.2, height:  (210) * 0.65 )
                                .overlay{
                                    Text("No Image")
                                }
                              
                            
                        }else{
                            vm.images.first!
                                .resizable()
                                .scaledToFill()
                                .frame(width: screen.width / 2.2, height:  (210) * 0.65 )
                                .clipped()
                            
                                
                        }
                    }
                    .overlay(alignment:.topTrailing){
                        Button{
                            wished.tapedToHeart(product: vm.product)
                        }label: {
                            Image(systemName: "heart.fill" )
                                .foregroundColor(wished.checkWish(product: vm.product) ? Color("customRed") : Color.secondary )
                                .font(.system(size: 21))
                                .shadow(color:.white,radius: 1)
                               
                        }
                        .padding(7)
                        .padding(.top,2)
                        
                    }
                    
                    
                    VStack(spacing:5){
                        HStack{
                            
                            Text("\(vm.product.price.formatted()) ₼")
                                .fontWeight(.medium)
                                .foregroundColor(Color.accentColor)
                                .font(.system(size: 14))
                            Spacer()
                        }
                        HStack{
                            Text(vm.product.name)
                                .font(.system(size: 14))
                                .foregroundColor(colorScheme == .dark ? .white :.black)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                       
                        
                        HStack{
                            Text(vm.product.category)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                                .padding(.leading,1)
                            Spacer()
                        }
                       
                        Spacer()
                    }
                    .padding(.top,5)
                    .padding(.horizontal,7)
                    .frame(width: screen.width / 2.2, height:  (210) * 0.35 )
                    
                }
              
                
                
                
            }
            .frame(width: screen.width / 2.25, height:  210)
            .cornerRadius(10)
           
           
            
            
        }
            
       
        
        
        
    }
}

struct ProductPosts_View_Previews: PreviewProvider {
    
   
    @State static var example =  Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 ")
    
    static var previews: some View {
       var vm = ProductPosts_ViewModel(product: $example)
        ProductPosts_View(vm:  vm)
            .environmentObject(WishedProducts())
    }
}
