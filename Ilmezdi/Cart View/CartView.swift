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
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.1).ignoresSafeArea()
                ScrollView(.vertical){
                    VStack{
                        Divider()
                        ForEach(cart.cartProducts){product in
                            
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity , alignment: .top)
                    .padding(.horizontal)
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
                                                   .font(.system(size: 18))
                                           }
                                           .frame(width: 40)
                                       }
                }
                ToolbarItem(placement: .principal, content: {
                    Text("Sebetim")
                        .bold()
                        .font(.system(size: 22))
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
