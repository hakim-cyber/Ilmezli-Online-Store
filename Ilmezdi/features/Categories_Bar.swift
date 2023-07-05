//
//  Categories_Bar.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct Category{
    let title:String
    let image:String
}


struct Categories_Bar: View {
    @Binding var selectgCategory:Category?
    let categories = [
        Category(title: "Ev", image: "house.lodge.circle"),Category(title: "Mətbəx", image: "fork.knife"),Category(title: "Texnika", image: "desktopcomputer"),Category(title: "Tikinti", image: "building.2.crop.circle"),Category(title: "Xirdavat", image: "light.ribbon"),
    ]
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        
            ScrollView(.horizontal,showsIndicators: false){
                LazyHStack(spacing: screen.width / 13){
                    ForEach(categories,id: \.title) { category in
                        VStack(alignment: .center,spacing: 15){
                           Image(systemName: "\(category.image)")
                                .font(.title3)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.ultraThinMaterial))
                                .opacity(0.7)
                            Text("\(category.title)")
                                .foregroundColor(.gray.opacity(0.7))
                        }
                    
                        
                    }
                }.padding(.horizontal)
            }
        
        
    }
}

struct Categories_Bar_Previews: PreviewProvider {
    static var previews: some View {
        Categories_Bar(selectgCategory: .constant(nil))
    }
}
