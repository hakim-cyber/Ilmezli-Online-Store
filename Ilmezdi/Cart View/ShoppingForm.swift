//
//  ShoppingForm.swift
//  Ilmezdi
//
//  Created by aplle on 7/17/23.
//

import SwiftUI

struct ShoppingForm: View {
    @EnvironmentObject var cart:Cart_ViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("name")  var name = ""
    @AppStorage("phoneNumber")  var phoneNumber = ""
    
    @AppStorage("soyad") var soyad = ""
    
    @State private var shpwAdressForm = false
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            if shpwAdressForm{
                AdressForm(){
                    dismiss()
                }
                
            }else{
                VStack(spacing: 20){
                    Spacer()
                    VStack(spacing: 10){
                        HStack(spacing: 15){
                            VStack(spacing:5){
                                HStack{
                                    Text("Ad")
                                        .font(.system(size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.gray.opacity(0.5))
                                    Spacer()
                                }
                                TextField("",text: $name)
                                    .padding(8)
                                    .padding(.horizontal,8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(name == "" ? Color.red : Color.primary))
                                    .keyboardType(.namePhonePad)
                                    
                            }
                            .frame(width: screen.width / 2.3)
                           
                            VStack(spacing:3){
                                HStack{
                                    Text("Soyad")
                                        .font(.system(size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.gray.opacity(0.5))
                                    Spacer()
                                }
                                TextField("",text: $soyad)
                                    .padding(8)
                                    .padding(.horizontal,8)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(name == "" ? Color.red : Color.primary))
                                    .keyboardType(.namePhonePad)
                            }
                            .frame(width: screen.width / 2.3)
                        }
                        
                        VStack(spacing:5){
                            HStack{
                                Text("Nomre")
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray.opacity(0.5))
                                Spacer()
                            }
                            TextField("",text: $phoneNumber)
                                .padding(8)
                                .padding(.horizontal,8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(phoneNumber == "" ? Color.red : Color.primary))
                                
                                .keyboardType(.phonePad)
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Button{
                        withAnimation(.easeInOut){
                            self.shpwAdressForm = true
                        }
                    }label: {
                        Text("Davam Ele")
                            .foregroundColor(.white)
                            .frame(width: screen.width / 1.2,height: 40)
                            .listRowBackground(Color.clear)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    .disabled(name == "" || phoneNumber == "" || soyad == "")
                  
                }
                .padding(.horizontal,20)
                .padding(.vertical)
                .scrollDismissesKeyboard(.immediately)
                .transition(.move(edge: .top))
            }
        }
    }
    
}

struct ShoppingForm_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingForm()
            .environmentObject(Cart_ViewModel())
    }
}
