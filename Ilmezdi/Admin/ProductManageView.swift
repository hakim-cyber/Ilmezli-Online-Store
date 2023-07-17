//
//  ProductManageView.swift
//  Ilmezdi
//
//  Created by aplle on 7/12/23.
//

import SwiftUI

struct ProductManageView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var productData:ProductsData
    
    @State private var screen  = UIScreen.main.bounds
    @State private var showDelete = false
    @State private var showNewProductAddView = false
    @State private var selectedProductForEdit:Product?
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20){
                   
                    ForEach(productData.exampleProducts){product in
                        VStack{
                            HStack(spacing:15){
                                if showDelete{
                                    Button{
                                        // deleting
                                        withAnimation(.easeInOut){
                                            productData.deleteProduct(product: product)
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
                                            
                                            Text("\(product.price.formatted()) ₼")
                                                .font(.system(size: 15))
                                                .fontWeight(.bold)
                                                .foregroundColor(.accentColor)
                                            Spacer()
                                            
                                            
                                        }
                                        .padding(.top,4)
                                        
                                    }
                                    
                                    
                                    
                                    Spacer()
                                    if product.images == []{
                                        
                                    }else{
                                        productData.useImage(text: product.images.first ?? "")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80)
                                            .background( Color.gray.opacity(0.3))
                                            .cornerRadius(7)
                                    }
                                    
                                }
                                .padding(.vertical,5)
                                
                                
                                
                            }
                            .contentShape(Rectangle())
                            .onTapGesture{
                                self.selectedProductForEdit = product
                            }
                            
                           
                        }
                        .frame( height: screen.height / 10)
                        Divider()
                            .tint(Color.secondary)
                        
                        
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.gray.opacity(0.1).ignoresSafeArea())
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
                    Text("Mehsullar")
                        .bold()
                        .font(.system(size: 22))
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button{
                        //add new product
                        self.showNewProductAddView = true
                    }label:{
                        ZStack{
                            Circle().fill(Color.gray.opacity(0.09))
                            Image(systemName: "plus")
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                        .frame(width: 40)
                    }
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
            .sheet(item: $selectedProductForEdit){product in
                // edit view
                NewProductAddView(editingProduct: product)
            }
            .sheet(isPresented: $showNewProductAddView){
                //show add view
                NewProductAddView()
            }
        }
        
    }
}

struct ProductManageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductManageView()
            .environmentObject(ProductsData())
    }
}
