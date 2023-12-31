//
//  SearcPost.swift
//  Ilmezdi
//
//  Created by aplle on 8/4/23.
//

import SwiftUI

struct SearcPost: View {
   var product:Product
    var showFull:()->Void
    
    @State private var screen = UIScreen.main.bounds
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var cart:Cart_ViewModel
    
    @State private var askCount = false
    var body: some View {
        HStack{
            HStack(spacing: 10){
                if product.images != []{
                    useImage(text: product.images.first ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60)
                        .frame(maxHeight:screen.height / 11)
                        .clipped()
                        .cornerRadius(10)
                }
                VStack(alignment: .leading){
                    
                    Text(product.name)
                        .font(.system(size: 16))
                        .foregroundColor(colorScheme == .dark ? .white :.black)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                    
                    
                    Text("\(product.category)")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .fontWeight(.light)
                    
                    
                    
                    
                }
                .frame(maxHeight:screen.height / 11)
                
            }
            .onTapGesture {
                showFull()
            }
            Spacer()
            Button{
                withAnimation{
                    askCount = true
                    cart.addProduct(product: product)
                }
            }label: {
               
            
               
                Text("\(product.price.formatted()) ₼")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
              
              
                    Image(systemName: "plus.circle")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.accentColor)
                
                
            }
            
            
           
        }
        .padding(.horizontal)
        
    }
    func useImage(text:String)->Image{
           let data = Data(base64Encoded: text) ?? Data()
           
           let uiImage = UIImage(data: data) ?? UIImage()
           
           return Image(uiImage: uiImage)
       }
}

struct SearcPost_Previews: PreviewProvider {
    static var previews: some View {
        SearcPost(product: Product(id: "", name: "Test", description: "Test Product", images: [], category: "Hamisi", price: 150, postDate: "")){
            
        }
            .environmentObject(Cart_ViewModel())
    }
}
