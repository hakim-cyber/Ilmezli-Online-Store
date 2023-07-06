//
//  Categories_Bar.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI




struct Categories_Bar: View {
    @Binding var selectedCategory:Category?
    let categories = [
        Category(title: "Ev", image: "house.lodge.circle"),Category(title: "Mətbəx", image: "fork.knife"),Category(title: "Texnika", image: "desktopcomputer"),Category(title: "Tikinti", image: "building.2.crop.circle"),Category(title: "Xirdavat", image: "light.ribbon"),
    ]
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        
            ScrollView(.horizontal,showsIndicators: false){
                LazyHStack(spacing: screen.width / 15){
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
                        .onTapGesture {
                            self.selectedCategory = category
                        }
                        
                        
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 100)
           
        
        
        
    }
}

struct Categories_Bar_Previews: PreviewProvider {
    static var previews: some View {
        Categories_Bar(selectedCategory: .constant(nil))
    }
}
