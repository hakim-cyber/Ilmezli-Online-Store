//
//  ProductFull_Ui.swift
//  Ilmezdi
//
//  Created by aplle on 7/7/23.
//

import SwiftUI

struct ProductFull_Ui: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var productData:ProductsData
    var body: some View {
        VStack{
            Button("Back"){
                dismiss()
            }
        }
    }
}

struct ProductFull_Ui_Previews: PreviewProvider {
    static var previews: some View {
        ProductFull_Ui()
            .environmentObject(ProductsData())
    }
}
