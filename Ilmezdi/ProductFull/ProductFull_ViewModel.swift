//
//  ProductFull_ViewModel.swift
//  Ilmezdi
//
//  Created by aplle on 7/7/23.
//

import SwiftUI

class ProductFull_ViewModel:ObservableObject{
    @Binding var product:Product
     
     init(product: Binding<Product>) {
         self._product = product
     }
}
