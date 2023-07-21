//
//  ProductFull_Ui.swift
//  Ilmezdi
//
//  Created by aplle on 7/7/23.
//

import SwiftUI

struct ProductFull_Ui: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var productData:ProductsData
    @EnvironmentObject var wished:WishedProducts
    @EnvironmentObject var cart:Cart_ViewModel
    @ObservedObject var vm:ProductFull_ViewModel
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
           
            VStack(spacing:20){
                
                HStack(spacing:20){
                    Button{
                        dismiss()
                    }label: {
                        ZStack{
                            Circle().fill(Color.gray.opacity(0.09))
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 13))
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                        .frame(width: 40)
                    }
                    Spacer()
                    Button{
                        wished.tapedToHeart(product: vm.product)
                    }label: {
                        ZStack{
                            Circle().fill(Color.gray.opacity(0.09))
                            
                            Image(systemName: "heart.fill" )
                                .foregroundColor(wished.checkWish(product: vm.product) ? Color("customRed") : Color.secondary )
                                .font(.system(size: 22))
                                .shadow(color:.white,radius: 2)
                        }
                        .frame(width: 40)
                    }
                    
                    
                }
                .padding(.top,10)
                VStack{
                ScrollView(showsIndicators: false){
                    VStack(spacing: 30){
                        if vm.images == []{
                            Color.gray.opacity(0.3)
                                .frame(width: screen.width * 0.88,height: screen.height * 0.38)
                                .overlay{
                                    Text("No Image")
                                }
                                .cornerRadius(10)
                            
                        }else{
                            Product_ImageSlider(images: vm.images)
                        }
                        VStack(spacing:10){
                            HStack{
                                Image(systemName: "square.stack.3d.up.fill")
                                    .foregroundColor(.secondary)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.leading)
                                Text(vm.product.category)
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack{
                                Text(vm.product.name)
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.trailing,5)
                            
                          
                            
                            HStack{
                                Text("\(vm.product.description)")
                                Spacer()
                            }
                            .padding(.top,7)
                            Divider()
                                .opacity(0.7)
                                .padding(.top,5)
                            HStack{
                                Text("\(vm.stringToDate(string: vm.product.postDate).formatted(date: .numeric, time: .shortened))")
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.top,5)
                        }
                        VStack{
                            
                        }
                        .frame(height:screen.height / 9)
                        Spacer()
                        
                    }
                    
                    
                }
                
            }
               
            
            
        }
        
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .padding(.horizontal)
    
            
            
            VStack{
                Spacer()
                VStack{
                    HStack{
                        VStack(alignment: .leading,spacing: 5){
                            Text("Qiymət:")
                                .foregroundColor(.secondary)
                            Text("\(vm.product.price.formatted()) ₼")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                        Button{
                            // add to cart
                            cart.addProduct(product: vm.product)
                            dismiss()
                        }label: {
                            HStack{
                                
                                Text("Əlave Et")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(8)
                                    .padding(.horizontal,9)
                                    .background(RoundedRectangle(cornerRadius: 10))
                            }
                                
                        }
                    }
                    .padding(.horizontal,20)
                }
                .frame(maxWidth: .infinity,maxHeight:screen.height / 9)
                .background()
                .ignoresSafeArea()
            }
        }
    }
}
struct ProductFull_Ui_Previews: PreviewProvider {
    @State static var example =  Product(id: UUID().uuidString, name: "Essentials Men's Short-Sleeve Crewneck T-Shirt", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 ")
    static var previews: some View {
        ProductFull_Ui(vm: ProductFull_ViewModel(product: $example))
            .environmentObject(ProductsData())
            .environmentObject(Cart_ViewModel())
            .environmentObject(WishedProducts())
    }
}
