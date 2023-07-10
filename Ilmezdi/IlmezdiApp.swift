//
//  IlmezdiApp.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

@main
struct IlmezdiApp: App {
    @StateObject var productsData = ProductsData()
    @StateObject var cart = Cart_ViewModel()
    var body: some Scene {
        WindowGroup {
           Start_Screen()
                .environmentObject(productsData)
                .environmentObject(cart)
        }
    }
}
