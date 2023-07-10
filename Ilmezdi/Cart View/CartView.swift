//
//  CartView.swift
//  Ilmezdi
//
//  Created by aplle on 7/10/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart:Cart_ViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var screen = UIScreen.main.bounds
    
   @State private var showDelete = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.1).ignoresSafeArea()
                ScrollView(.vertical){
                    VStack(spacing: 10){
                        Divider()
                            .tint(.secondary)
                        ForEach(cart.cartProducts){product in
                            VStack{
                                HStack(spacing:15){
                                    if showDelete{
                                        Button{
                                            // deleting
                                            withAnimation(.easeInOut){
                                                cart.deleteProduct(product: product)
                                            }
                                                           }label: {
                                                               ZStack{
                                                                   RoundedRectangle(cornerRadius: 9)
                                                                       .fill(Color.red.opacity(0.1))
                                                                   Image(systemName: "trash.fill")
                                                                       .font(.system(size:18))
                                                                       .foregroundColor(.red)
                                                               }
                                                               .frame(width: 40, height: 40)
                                                                 
                                                           }
                                                           .padding(.trailing,10)
                                    }
                                    HStack(alignment: .center,spacing:10){
                                        if product.images == []{
                                            
                                        }else{
                                            cart.useImage(text: product.images.first ?? "")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80)
                                                .background( Color.gray.opacity(0.3))
                                                .cornerRadius(7)
                                        }
                                        VStack(spacing:6){
                                            HStack{
                                                Text(product.name)
                                                    .font(.system(size: 16))
                                                    .foregroundColor(colorScheme == .dark ? .white :.black)
                                                    .fontWeight(.medium)
                                                    .multilineTextAlignment(.leading)
                                                Spacer()
                                                
                                            }
                                            HStack{
                                                Text(product.category)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.secondary)
                                                    .fontWeight(.light)
                                                    .multilineTextAlignment(.leading)
                                                Spacer()
                                            }
                                            
                                            HStack{
                                                
                                                Text("\(product.price.formatted())0 ₼")
                                                    .font(.system(size: 15))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.accentColor)
                                                Spacer()
                                                
                                                HStack{
                                                    Button{
                                                        withAnimation{
                                                            cart.decreaseProduct(product: product)
                                                        }
                                                    }label:{
                                                        ZStack{
                                                            Circle().stroke(colorScheme == .light ? .black : .white)
                                                            
                                                            Image(systemName: "minus")
                                                                .foregroundColor(colorScheme == .light ? .black : .white)
                                                                .font(.system(size: 15))
                                                            
                                                        }
                                                        .frame(width: 23)
                                                    }
                                                    .disabled(!(product.count > 1))
                                                    Text("\(product.count)")
                                                    Button{
                                                        withAnimation{
                                                            cart.addProduct(product: product)
                                                        }
                                                    }label:{
                                                        ZStack{
                                                            Circle().fill(colorScheme == .light ? .black : .white)
                                                            
                                                            Image(systemName: "plus")
                                                                .foregroundColor(colorScheme == .light ? .white : .black)
                                                                .font(.system(size: 15))
                                                            
                                                        }
                                                        .frame(width: 23)
                                                    }
                                                }
                                                .padding(5)
                                                .background(Color.gray.opacity(0.12))
                                                .cornerRadius(15)
                                            }
                                            .padding(.top,4)
                                            
                                        }
                                        
                                        
                                        
                                        Spacer()
                                        
                                    }
                                    .padding(.vertical,5)
                                   
                                    
                                    
                                }
                                
                                Divider()
                                    .tint(.secondary)
                            }
                            .frame( height: screen.height / 7)
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity , alignment: .top)
                    .padding(.horizontal)
                }
                
                
                VStack{
                    Spacer()
                    VStack(spacing:0){
                        Spacer()
                        HStack{
                            Text("Umumi:")
                                .font(.system(size:14))
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(cart.totalPrice.formatted()) ₼")
                                .bold()
                                .foregroundColor(.accentColor)
                        }
                        .padding(.horizontal)
                        Spacer()
                        Button{
                            
                        }label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                   Text("Zakaz Ele")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .frame(width:screen.width * 0.8,height:screen.height / 20)
                        }
                        .padding(.bottom, 5)
                    }
                    .frame(maxWidth: .infinity,maxHeight:screen.height / 8)
                    .background()
                    .ignoresSafeArea()
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                                           //back
                        dismiss()
                                       }label: {
                                           ZStack{
                                               Circle().fill(Color.gray.opacity(0.09))
                                               
                                               Image(systemName: "chevron.left")
                                                   .font(.system(size: 16))
                                                   .foregroundColor(colorScheme == .light ? .black : .white)
                                           }
                                           .frame(width: 40)
                                       }
                }
                ToolbarItem(placement: .principal, content: {
                    Text("Sebetim")
                        .bold()
                        .font(.system(size: 22))
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    if !showDelete{
                        Menu{
                            Button("Remove Products",role:.destructive){
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6)){
                                    self.showDelete = true
                                }
                            }
                            
                            
                            
                        }label:{
                            ZStack{
                                Circle().fill(Color.gray.opacity(0.09))
                                Image(systemName: "ellipsis")
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }
                            .frame(width: 40)
                        }
                    }else{
                        Button("Done"){
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6)){
                                showDelete = false
                            }
                               
                        }
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .bold()
                    }
                })
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Cart_ViewModel())
    }
}