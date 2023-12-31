//
//  SettingsView.swift
//  Ilmezdi
//
//  Created by aplle on 7/11/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var productsData:ProductsData
   @AppStorage("isAdmin") var isAdmin = false
    @State private var password = "5555"
    
    @State private var writtenPassword = ""
   @State private var showPasswordControl = false
    @State private var showProductManageView = false
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            Form{
                Section{
                    if !isAdmin{
                        Button{
                            if !isAdmin{
                                withAnimation {
                                    showPasswordControl = true
                                }
                            }
                        }label: {
                            HStack{
                                Spacer()
                                Text("Daxil ol")
                                Spacer()
                            }
                        }
                    }else{
                        Button{
                            if isAdmin{
                                self.showProductManageView = true
                            }
                        }label: {
                            HStack{
                                Text("Məhsullar")
                                Spacer()
                                Text("📲")
                            }
                        }
                    }
                }header: {
                    HStack{
                        Text("Admin Paneli")
                        Spacer()
                        if isAdmin{
                            Text("✅")
                        }else{
                            Text("📛")
                        }
                            
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .alert("Admin Panelinə Giriş", isPresented: $showPasswordControl){
                SecureField("Parol", text: $writtenPassword)
                Button("Gir"){
                    if writtenPassword.trimmingCharacters(in: .whitespacesAndNewlines) == password{
                        isAdmin = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showProductManageView){
               ProductManageView()
            }
           
            
        }
            
            
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
