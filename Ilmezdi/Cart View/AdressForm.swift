//
//  AdressForm.swift
//  Ilmezdi
//
//  Created by aplle on 7/23/23.
//

import SwiftUI
enum AdressType:String,CaseIterable{
    case seherDaxili , metroya , poct , hecbiri
}

struct AdressForm: View {
    @State private var selectedAdresstype = AdressType.seherDaxili
    
    @State private var adress = ""
    @AppStorage("name")  var name = ""
    @AppStorage("phoneNumber")  var phoneNumber = ""
    
    @State private var

       @State private var screen = UIScreen.main.bounds
    
    @EnvironmentObject var cart:Cart_ViewModel
        
        @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 25){
                HStack(spacing: 20){
                    ForEach(AdressType.allCases , id:\.rawValue){type in
                       
                        VStack(spacing: 5){
                            
                            Text("\(type.rawValue.uppercased())")
                                .fontWeight(.bold )
                                .font(.system(size: 15))
                                .foregroundColor(self.selectedAdresstype == type ? Color.accentColor:Color.primary)
                            
                          
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                self.selectedAdresstype = type
                            }
                        }
                        
                    }
                }
                
                switch selectedAdresstype {
                case .seherDaxili:
                    VStack{
                        HStack{
                            Text("Adresiniz")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray.opacity(0.5))
                            Spacer()
                        }
                        TextField("",text: $adress)
                            .padding(8)
                            .padding(.horizontal,8)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(adress == "" ? Color.red : Color.primary))
                            .keyboardType(.namePhonePad)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    
                    
                case .metroya:
                    VStack{
                        HStack{
                            Text("Metro Stansiyasi")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray.opacity(0.5))
                            Spacer()
                        }
                        TextField("",text: $adress)
                            .padding(8)
                            .padding(.horizontal,8)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(adress == "" ? Color.red : Color.primary))
                            .keyboardType(.namePhonePad)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    
                case .poct:
                    Text(" ")
                case .hecbiri:
                    Text("Bizim unvan: Ilmezdi")
                }
               
                
            }
            .padding(.top)
            .padding(.horizontal)
            .frame(height: screen.height * 0.35,alignment: .top)
        }
    }
    
}

struct AdressForm_Previews: PreviewProvider {
    static var previews: some View {
        AdressForm()
            .environmentObject(Cart_ViewModel())
    }
}
