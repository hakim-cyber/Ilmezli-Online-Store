//
//  SearchBar.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text:String
    @FocusState var focused
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        TextField(" 🔍 Search...", text: $text)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2),lineWidth: 1))
            .textFieldStyle(.plain)
            .focused($focused)
            .frame(width: screen.width / 1.8)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
