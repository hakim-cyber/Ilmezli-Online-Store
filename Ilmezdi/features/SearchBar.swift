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
        TextField("  Search...", text: $text)
            .padding(10)
            .padding(2)
            .keyboardType(.default)
            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.3),lineWidth: 1.5))
            .textFieldStyle(.plain)
           
            .overlay(alignment: .trailing, content: {
                Button{
                    withAnimation(.easeInOut){
                        text = ""
                    }
                }label: {
                    Image(systemName: "xmark")
                }
                .padding(.trailing,8)
            })
            
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
