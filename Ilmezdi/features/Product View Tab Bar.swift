//
//  Product View Tab Bar.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct Item:Identifiable,Equatable{
    let id: String
  
}

struct CategoryPreference:Equatable{
    let item:Item
    let anchor :Anchor<CGRect>
}


struct categoryPreferenceKey:PreferenceKey{
    static var defaultValue = [CategoryPreference]()
    
    static func reduce(value: inout [CategoryPreference], nextValue: () -> [CategoryPreference]) {
        value.append(contentsOf: nextValue())
    }
}


struct CategoryButton:View{
    var item:Item
    
    @Binding var selection:Item?
    
    var body: some View{
        
            VStack{
                Text(item.id)
                    .font(.title3)
                    .foregroundColor(Color.accentColor)
            }.onTapGesture {
                withAnimation{
                    selection = item
                }
            }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(item.id)
        .anchorPreference(key: categoryPreferenceKey.self,value:.bounds,transform: {
            [CategoryPreference(item: item, anchor: $0)]
        })
    }
}





struct Product_View_Tab_Bar: View {
    @State private var selectedItem:Item?
    
    let items =
    [
      Item(id: "Haqqinda"),
      Item(id: "Əlaqə")
  
    ]
    @State private var width = 0.0
    var body: some View {
        VStack{
            HStack(spacing: 20){
                ForEach(items){item in
                    CategoryButton(item: item, selection: $selectedItem)
                }
            }
        }
        .overlayPreferenceValue(categoryPreferenceKey.self){preferences in
            GeometryReader{proxy in
                if let selected = preferences.first(where:{$0.item == selectedItem}){
                    let frame = proxy[selected.anchor]
                    
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: frame.width,height: 1.5)
                        .offset(x: frame.minX,y:frame.maxY)
                }
            }
           
        }
        .onAppear{
            withAnimation {
                selectedItem = items.first
            }
        }
    }
}

struct Product_View_Tab_Bar_Previews: PreviewProvider {
    static var previews: some View {
        Product_View_Tab_Bar()
    }
}
