//
//  ContentView.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var h = false
    @EnvironmentObject var productsData:ProductsData
    @EnvironmentObject var cart:Cart_ViewModel
    var body: some View {
        VStack {
            TabView{
               Home_View()
                    .tabItem {
                        Label("Ana Sayfa", systemImage: "house")
                           
                    }
                Text("Favorilerim")
                    .tabItem {
                       Label("Favorilerim", systemImage: "heart")
                    }
                Text("Əlaqə")
                    .tabItem {
                    Label("Əlaqə", systemImage: "phone")
                    }
                SettingsView()
                    .tabItem {
            Label("Ayarlar", systemImage: "gear")
                  }
            }
        }
        .fullScreenCover(isPresented: $productsData.showCartView, content: {
            
            CartView()
        })
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProductsData())
            .environmentObject(Cart_ViewModel())
    }
}
