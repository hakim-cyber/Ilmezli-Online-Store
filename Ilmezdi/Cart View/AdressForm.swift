//
//  AdressForm.swift
//  Ilmezdi
//
//  Created by aplle on 7/23/23.
//

import SwiftUI
enum AdressType:String,CaseIterable{
    case seherDaxili , metroya , poct , yerinde
}

struct AdressForm: View {
    var dismiss:()->Void
    @State private var selectedAdresstype = AdressType.seherDaxili
    
    @State private var adress = ""
    @AppStorage("name")  var name = ""
    @AppStorage("phoneNumber")  var phoneNumber = ""
    @AppStorage("soyad")  var soyad = ""

       @State private var screen = UIScreen.main.bounds
    
    @EnvironmentObject var cart:Cart_ViewModel
        
       
    
    var body: some View {
       
           
            VStack(spacing: 25){
                HStack(spacing: 25){
                    ForEach(AdressType.allCases , id:\.rawValue){type in
                       
                        VStack(spacing: 5){
                            
                            Text("\(type.rawValue.uppercased())")
                                .fontWeight(.bold )
                                .font(.system(size: screen.width / 4 / 7))
                                .foregroundColor(self.selectedAdresstype == type ? Color.accentColor:Color.primary)
                            
                            Text("\(catdirilmaPulu(type:type) == 0 ? String("Pulsuz") : String( "\(catdirilmaPulu(type: type) ) ₼"))")
                                .font(.system(size: screen.width / 4 / 9))
                                .fontWeight(.bold)
                                .foregroundColor(self.selectedAdresstype == type ? Color.accentColor.opacity(0.8) : Color.primary.opacity(0.5))
                            
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
                                .font(.system(size: screen.width / 4 / 7.2))
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary.opacity(0.5))
                            Spacer()
                        }
                        TextField("",text: $adress)
                            .padding(8)
                            .padding(.horizontal,8)
                            .frame(width: screen.width / 1.1,height: screen.height / 18)
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
                                .foregroundColor(Color.primary.opacity(0.5))
                            Spacer()
                        }
                        TextField("",text: $adress)
                            .padding(8)
                            .padding(.horizontal,8)
                            .frame(width: screen.width / 1.1,height: screen.height / 18)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(adress == "" ? Color.red : Color.primary))
                            .keyboardType(.namePhonePad)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    
                case .poct:
                    VStack{
                        HStack{
                            VStack(alignment: .leading,spacing:5){
                                Text("Poct Unvani Ve Indexi (AZ)")
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.primary.opacity(0.5))
                                
                            }
                            Spacer()
                        }
                        TextField("",text: $adress)
                            .padding(8)
                            .padding(.horizontal,8)
                            .frame(width: screen.width / 1.1,height: screen.height / 18)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(adress == "" ? Color.red : Color.primary))
                            .keyboardType(.namePhonePad)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                case .yerinde:
                    Text("Bizim unvan: Ilmezdi")
                       
                }
                
                Spacer()
               
                Button{
                    withAnimation(.easeInOut){
                       placeOrder()
                    }
                }label: {
                    Text("Tamamla")
                        .foregroundColor(.white)
                        .frame(width: screen.width / 1.6,height: screen.height / 16)
                        .listRowBackground(Color.clear)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .disabled(adress == "")
             
            }
            .padding(.top)
            .padding(.horizontal)
            .frame(height: screen.height * 0.35,alignment: .top)
        
    }
    func placeOrder(){
        var countryCode = "+994"
        var mobileNumber = "519782020"
        
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
    Ad: \(name)
    Soyad: \(soyad)
    Nomre: \(phoneNumber)
    Adress: \(generateAdressString())
    
    Zakaz:
    
    \(productstext)
    \(catdirilmaPulu(type: selectedAdresstype) == 0 ? "Catdirilma \(selectedAdresstype.rawValue) Pulsuz" : "Catdirilma (\(selectedAdresstype.rawValue.uppercased())) + \(catdirilmaPulu(type: selectedAdresstype)) ₼" )
    
    Umumi: \(Double(cart.totalPrice + Double(catdirilmaPulu(type: selectedAdresstype))).formatted()) ₼ """
        return text
    }
    
    func generateAdressString()->String{
        switch selectedAdresstype {
        case .seherDaxili:
            return  "\(adress) (SeherDaxili)"
        case .metroya:
            return  "\(adress) (Metrosu)"
        case .poct:
            return "\(adress) (Poct)"
        case .yerinde:
           return "Yerinde"
        }
    }
    func catdirilmaPulu(type:AdressType)->Int{
        switch type {
        case .seherDaxili:
            return 5
        case .metroya:
            return 0
        case .poct:
            return 5
        case .yerinde:
            return 0
        }
    }
}

struct AdressForm_Previews: PreviewProvider {
    static var previews: some View {
        AdressForm(){
            
        }
            .environmentObject(Cart_ViewModel())
    }
}
