//
//  CartView.swift
//  Ilmezdi
//
//  Created by aplle on 7/10/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart:Cart_ViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Cart_ViewModel())
    }
}
