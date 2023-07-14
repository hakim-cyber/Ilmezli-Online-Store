//
//  Product_ImageSlider.swift
//  Ilmezdi
//
//  Created by aplle on 7/9/23.
//

import SwiftUI

struct Product_ImageSlider: View {
    var images:[Image]
    
    @State private var screen = UIScreen.main.bounds
    @State private var indexOfImage = 0
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
               
                
                ZStack{
                    Color.gray.opacity(0.3)
                    
                    images[indexOfImage]
                        .resizable()
                        .scaledToFill()
                        .transition(.slide)
                    VStack{
                        Spacer()
                        HStack{
                            ForEach(0..<images.count , id: \.self){num in
                                Circle()
                                    .fill(num == indexOfImage ? Color.primary : Color.secondary)
                                    .frame(width: 10)
                                    .transition(.slide)
                                    
                            }
                        }
                    }
                    .padding(.bottom,10)
                    
                }
               
                .cornerRadius(7)
                .frame(width: screen.width * 0.8,height: screen.height * 0.38)
                .gesture(
                
                DragGesture()
                    .onChanged{info in
                        
                    }
                    .onEnded{info in
                        if info.translation.width < 0{
                            if indexOfImage != images.count - 1 {
                                withAnimation(.easeInOut){
                                    indexOfImage +=  1
                                }
                            }
                        }else if info.translation.width > 0  {
                            if indexOfImage != 0 {
                                withAnimation(.easeInOut){
                                    indexOfImage -=  1
                                }
                            }
                        }
                       
                    }
                
                )
               
                
              
            }
            
        }
            
    
        
    }
}

struct Product_ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        Product_ImageSlider(images: [Image("image"),Image("image2"),Image("image3"),Image("image4")])
    }
}
