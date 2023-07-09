//
//  heart togke.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct HeartToggleStyle: ToggleStyle {
    let font:Double
    @Environment(\.colorScheme) var colorScheme
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation(.easeInOut) {
                configuration.isOn.toggle()
            }
           
        }) {
            Image(systemName: configuration.isOn ? "heart.fill" : "heart")
                .foregroundColor(configuration.isOn ? Color("customRed") : colorScheme == .dark ? .white :.black)
                .font(.system(size: font))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
