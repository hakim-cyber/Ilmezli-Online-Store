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
    @ObservedObject var vm:ProductFull_ViewModel
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing:30){
                HStack(spacing:20){
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(colorScheme == .dark ? .white :.black)
                    }
                    Spacer()
                    Toggle("", isOn: $vm.product.IsWished)
                        .labelsHidden()
                        .toggleStyle(HeartToggleStyle(font: 22))
                    Button{
                        // Share
                        
                    }label: {
                        Image(systemName: "paperplane.circle")
                            .foregroundColor(colorScheme == .dark ? .white :.black)
                            .font(.system(size: 22))
                    }
                    Cart_(font: 22, itemCount: 4)
                }
            
                if vm.images == []{
                       Color.gray.opacity(0.3)
                        .frame(width: screen.width * 0.88,height: screen.height * 0.38)
                                                .overlay{
                                                    Text("No Image")
                                                    }
                                                .cornerRadius(7)
                                                                    
                                            }else{
                                            vm.images.first!
                                               .resizable()
                                               .scaledToFit()
                                              
                                               .background( Color.gray.opacity(0.3))
                                               .cornerRadius(7)
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
                        Text("\(vm.stringToDate(string: vm.product.postDate).formatted(date: .numeric, time: .shortened))")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.top,5)
                }
               
                Spacer()
               
                
            }
            
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.horizontal)
            
            VStack{
                Spacer()
                VStack{
                    HStack{
                        VStack(alignment: .leading,spacing: 5){
                            Text("Qiymet")
                                .foregroundColor(.secondary)
                            Text("₼\(vm.product.price.formatted())0")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                        Button{
                            // add to cart
                        }label: {
                            Text("Elave Et")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding()
                                .padding(.horizontal,12)
                                .background(RoundedRectangle(cornerRadius: 8))
                                
                        }
                    }
                    .padding(.horizontal,20)
                }
                .frame(maxWidth: .infinity,maxHeight:screen.height / 10)
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
    }
}
