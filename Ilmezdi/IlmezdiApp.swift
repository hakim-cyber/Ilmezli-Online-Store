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
    var body: some Scene {
        WindowGroup {
           Start_Screen()
                .environmentObject(productsData)
        }
    }
}
