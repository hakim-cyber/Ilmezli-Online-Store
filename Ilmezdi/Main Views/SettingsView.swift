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
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            Form{
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
