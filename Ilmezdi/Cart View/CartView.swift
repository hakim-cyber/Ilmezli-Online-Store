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
    @State private var showShoppingForm = false
    
   @State private var showDelete = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.1).ignoresSafeArea()
                if cart.cartProducts.count == 0{
                    VStack(){
                        Spacer()
                        VStack(alignment: .center,spacing: 15){
                          
                            
                            Text("Səbətiniz Boşdu ☹️")
                                .fontWeight(.medium)
                                .font(.title2)
                            
                            Button{
                                dismiss()
                            }label: {
                                ZStack{
                                    Rectangle()
                                        .frame(width: screen.width / 1.6,height: screen.height / 17)
                                        .cornerRadius(10)
                                    Text("Alış-verişə Başlayın")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                            }
                            .padding(.top,10)
                        }
                        Spacer()
                        Spacer()
                    }
                    
                }else{
                    ScrollView(.vertical){
                        VStack(spacing: 20){
                           
                            ForEach(cart.cartProducts){product in
                                HStack(spacing: 10){
                                    if showDelete{
                                        Button{
                                            // deleting
                                            withAnimation(.easeInOut){
                                                cart.deleteProduct(product: product.product)
                                            }
                                        }label: {
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.red.opacity(0.1))
                                                Image(systemName: "trash.fill")
                                                    .font(.system(size:18))
                                                    .foregroundColor(.red)
                                            }
                                            .frame(width: 40, height: 40)
                                            
                                        }
                                        .padding(.trailing,10)
                                    }
                                    VStack{
                                        HStack(spacing:8){
                                            
                                            HStack(alignment: .center,spacing:10){
                                                if product.product.images == []{
                                                    
                                                }else{
                                                    cart.useImage(text: product.product.images.first ?? "")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 100)
                                                        .clipped()
                                                        .cornerRadius(10)
                                                      
                                                        
                                                       
                                                }
                                                VStack(spacing:3){
                                                    HStack{
                                                        Text(product.product.name)
                                                            .font(.system(size: 16))
                                                            .foregroundColor(colorScheme == .dark ? .white :.black)
                                                            .fontWeight(.medium)
                                                            .multilineTextAlignment(.leading)
                                                        Spacer()
                                                        
                                                    }
                                                    HStack{
                                                        Text(product.product.category)
                                                            .font(.system(size: 12))
                                                            .foregroundColor(.secondary)
                                                            .fontWeight(.light)
                                                            .multilineTextAlignment(.leading)
                                                        Spacer()
                                                    }
                                                    
                                                    HStack{
                                                        
                                                        Text("\(product.product.price.formatted()) ₼")
                                                            .font(.system(size: 15))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.accentColor)
                                                        Spacer()
                                                        if !showDelete{
                                                            HStack{
                                                                Button{
                                                                    withAnimation{
                                                                        cart.decreaseProduct(product: product.product)
                                                                    }
                                                                }label:{
                                                                    ZStack{
                                                                        
                                                                        
                                                                        Image(systemName: "minus")
                                                                            .foregroundColor(colorScheme == .light ? .black : .white)
                                                                            .font(.system(size: 15))
                                                                            .padding(7)
                                                                            .background(Circle().stroke(colorScheme == .light ? .black : .white))
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                }
                                                                .disabled(product.count == 1)
                                                                Text("\(product.count)")
                                                                Button{
                                                                    withAnimation{
                                                                        cart.addProduct(product: product.product)
                                                                    }
                                                                }label:{
                                                                    ZStack{
                                                                        
                                                                        
                                                                        Image(systemName: "plus")
                                                                            .foregroundColor(colorScheme == .light ? .white : .black)
                                                                            .font(.system(size: 15))
                                                                            .padding(4)
                                                                            .background(Circle().fill(colorScheme == .light ? .black : .white))
                                                                            .padding(3)
                                                                    }
                                                                    
                                                                }
                                                            }
                                                            .padding(5)
                                                            .background(Color.gray.opacity(0.12))
                                                            .cornerRadius(15)
                                                        }
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
                                    .frame( height: screen.height / 7.7)
                                   
                                }
                            }
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity , alignment: .top)
                        .padding(.horizontal)
                    }
                }
                
                
                VStack{
                    Spacer()
                    VStack(spacing:0){
                        Spacer()
                        HStack{
                            Text("Ümumi:")
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
                            self.showShoppingForm = true
                        }label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                   Text("Sifaris Elə")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .frame(width:screen.width * 0.8,height:screen.height / 20)
                        }
                        .padding(.bottom, 5)
                        .disabled(cart.cartProducts.count == 0)
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
                                               
                                               Image(systemName: "xmark")
                                                   .font(.system(size: 11))
                                                   .foregroundColor(colorScheme == .light ? .black : .white)
                                           }
                                           .frame(width: 40)
                                       }
                }
                ToolbarItem(placement: .principal, content: {
                    Text("Səbətim")
                        .bold()
                        .font(.system(size: 22))
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    if !showDelete{
                        Menu{
                            Button("Sil",role:.destructive){
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
                        .disabled(cart.cartProducts.count == 0)
                    }else{
                        Button("Tamam"){
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6)){
                                showDelete = false
                            }
                               
                        }
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .bold()
                    }
                })
            }
            .sheet(isPresented: $showShoppingForm, content: {
                ShoppingForm()
                    .presentationDetents([.fraction(0.4)])
                
            })
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Cart_ViewModel())
    }
}
