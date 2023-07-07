//
//  Home_ViewModel.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import Foundation

class Home_ViewModel:ObservableObject{
    @Published var searchText = ""
    @Published var selectedCategory:Category? = Category(title: "Hamısı", image: "square.stack.3d.up.fill")
}
