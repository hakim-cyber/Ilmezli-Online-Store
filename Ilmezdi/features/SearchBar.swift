//
//  SearchBar.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text:String
    @Binding var full:Bool
    @FocusState var focused
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        TextField("  Axtar...", text: $text)
            .padding(10)
            .padding(2)
            .keyboardType(.default)
            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3),lineWidth: 1.5))
            .textFieldStyle(.plain)
            .focused($focused)
            .onChange(of: focused){bool in
                withAnimation(.easeInOut(duration: 0.24)){
                    full = bool
                    
                }
            }
            .onChange(of: full){bool in
                withAnimation(.easeInOut(duration: 0.34)){
                    focused = bool
                    if full == false{
                        text = ""
                    }
                }
            }
            
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""),full: .constant(false))
    }
}
