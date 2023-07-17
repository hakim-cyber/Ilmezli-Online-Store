//
//  ShoppingForm.swift
//  Ilmezdi
//
//  Created by aplle on 7/17/23.
//

import SwiftUI

struct ShoppingForm: View {
    @EnvironmentObject var cart:Cart_ViewModel
    
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var adress = ""
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing: 20){
                Spacer()
                Spacer()
                Spacer()
                HStack{
                    TextField("Adiniz",text: $name)
                        .padding(8)
                        .padding(.horizontal,8)
                        .background(RoundedRectangle(cornerRadius: 7).stroke())
                        .frame(width: screen.width / 2.3)
                        .keyboardType(.namePhonePad)
                    Spacer()
                    TextField("Nomreniz",text: $phoneNumber)
                        .padding(8)
                        .padding(.horizontal,8)
                        .background(RoundedRectangle(cornerRadius: 7).stroke())
                        .frame(width: screen.width / 2.3)
                        .keyboardType(.phonePad)
                }
                .listRowBackground(Color.clear)
                TextField("Adresiniz",text: $adress)
                    .padding(8)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 7).stroke())
                    .keyboardType(.namePhonePad)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                
                Button{
                    placeOrder()
                }label: {
                    Text("Tamamla")
                        .foregroundColor(.white)
                        .frame(width: screen.width / 1.2,height: 40)
                        .listRowBackground(Color.clear)
                        .background(Color.accentColor)
                        .cornerRadius(7)
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .padding(.horizontal,20)
            .scrollDismissesKeyboard(.immediately)
        }
    }
    func placeOrder(){
        
    }
}

struct ShoppingForm_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingForm()
            .environmentObject(Cart_ViewModel())
    }
}
