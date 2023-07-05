//
//  ContentView.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var h = false
    var body: some View {
        VStack {
           Toggle("", isOn: $h)
                .labelsHidden()
                .toggleStyle(HeartToggleStyle(font: 36.6))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
