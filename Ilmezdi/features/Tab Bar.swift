//
//  Tab Bar.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct Tab_Bar: View {
    var body: some View {
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
            Text("Ayarlar")
                .tabItem {
        Label("Ayarlar", systemImage: "gear")
              }
        }
        
   
    }
}

struct Tab_Bar_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Bar()
    }
}
