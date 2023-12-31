//
//  ContentView.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var productsData:ProductsData
    @EnvironmentObject var cart:Cart_ViewModel
    var body: some View {
        VStack {
            TabView{
               Home_View()
                    .tabItem {
                        Label("Ana Sayfa", systemImage: "house")
                           
                    }
               WishView()
                    .tabItem {
                       Label("Favorilərim", systemImage: "heart")
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
        .onAppear{
            print(self.productsData.subscribedToNotification)
            if !self.productsData.subscribedToNotification{
                productsData.requestNotificationPermissions { nice in
                    if nice{
                        productsData.subscribeToNotifications { bool in
                            print(bool)
                            DispatchQueue.main.async {
                                self.productsData.subscribedToNotification = bool
                            }
                           
                            self.productsData.saveSubscribingBool()
                        }
                    }
                }
            }
            
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProductsData())
            .environmentObject(Cart_ViewModel())
    }
}
