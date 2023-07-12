//
//  NewProductAddView.swift
//  Ilmezdi
//
//  Created by aplle on 7/12/23.
//

import SwiftUI

struct NewProductAddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showImagePicker = false
    @State private var screen = UIScreen.main.bounds
    
    @State private var categoryOfProduct:Category?
    
    var body: some View {
        ZStack{
            
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing:30){
                HStack{
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(colorScheme == .dark ? .white :.black)
                    }
                    Spacer()
                  
                }
                if categoryOfProduct == nil{
                    
                }else{
                    HStack{
                        Color.gray.opacity(0.3)
                            .frame(width: screen.width * 0.88,height: screen.height * 0.13)
                            .overlay{
                                VStack(spacing: 8){
                                    Image(systemName: "camera.fill")
                                        .font(.title2)
                                    Text("Foto elave et")
                                }
                                .foregroundColor(.blue)
                                
                            }
                            .cornerRadius(7)
                            .onTapGesture {
                                showImagePicker = true
                            }
                    }
                }
                                                                    
                                           
                                        
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.horizontal)
        }
    }
}

struct NewProductAddView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductAddView()
    }
}
