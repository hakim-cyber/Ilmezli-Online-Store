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
    @AppStorage("adress") var adress = ""
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing: 20){
                Spacer()
                Spacer()
                Spacer()
                HStack{
                    TextField("Adınız",text: $name)
                        .padding(8)
                        .padding(.horizontal,8)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(name == "" ? Color.red : Color.primary))
                        .frame(width: screen.width / 2.3)
                        .keyboardType(.namePhonePad)
                    Spacer()
                    TextField("Nomrəniz",text: $phoneNumber)
                        .padding(8)
                        .padding(.horizontal,8)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(phoneNumber == "" ? Color.red : Color.primary))
                        .frame(width: screen.width / 2.3)
                        .keyboardType(.phonePad)
                }
                .listRowBackground(Color.clear)
                TextField("Adresiniz",text: $adress)
                    .padding(8)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(adress == "" ? Color.red : Color.primary))
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
                        .cornerRadius(10)
                }
                .disabled(name == "" || phoneNumber == "" || adress == "")
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
        var countryCode = "+994"
        var mobileNumber = "708315103"
        
        var text = generateString()
        let url = "https://wa.me/\(countryCode)\(mobileNumber)/?text=\(text)"
        
        let  urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let Url = NSURL(string: urlEncoded)
        
        if UIApplication.shared.canOpenURL(Url! as URL){
            print("Opening watsapp")
            
            UIApplication.shared.open(Url as! URL,options: [:]){status in
                print("opened watsapp chat")
                dismiss()
            }
        }else{
            print("Cant open ")
        }
    }
    func generateString()->String{
        var productstext = ""
        for product in cart.cartProducts{
            let productText = " \(product.product.name)    \(product.count) x \(product.product.price.formatted()) ₼ \n"
            productstext += productText
        }
        let text =
    """
    Ad:\(name)
    Nomre:\(phoneNumber)
    Adress:\(adress)
    
    Zakaz:
    
    \(productstext)
    Umumi: \(cart.totalPrice.formatted()) ₼
    """
        return text
    }
}

struct ShoppingForm_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingForm()
            .environmentObject(Cart_ViewModel())
    }
}
