//
//  Cart .swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct Cart_: View {
    let font:Double
    let itemCount:Int
    
    @EnvironmentObject var productsData:ProductsData
    
    var body: some View {
        
      Image(systemName: "handbag")
            .font(.system(size: font))
            .overlay(alignment: .topTrailing){
                if itemCount > 0{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("customRed"))
                        if itemCount <= 9{
                            Text("\(itemCount)")
                                .foregroundColor(.white)
                                .font(.system(size: font / 2.4))
                                
                        }else{
                            Text("9+")
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                    .padding(-3)
                    .frame(width:Double(font / 1.6),height: Double(font / 2))
                   
                }
            }
            .animation(.easeInOut, value: font)
            .onTapGesture {
                withAnimation(.easeInOut){
                    productsData.showCartView = true
                }
            }
    }
}

struct Cart__Previews: PreviewProvider {
    static var previews: some View {
        Cart_(font: 22, itemCount:1)
            .environmentObject(ProductsData())
    }
}
