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
    
    @State private var categoryOfProduct = ""
    @State private var titleOfProduct = ""
    @State private var descriptinOfProduct = ""
    @State private var priceOfProduct:Double?
    
    
    @EnvironmentObject var productData:ProductsData
    
    var body: some View {
        ZStack{
            
            Color.gray.opacity(0.1).ignoresSafeArea()
            Form{
                Section{
                    Picker("Kategoriya", selection: $categoryOfProduct){
                        ForEach(productData.categories,id:\.title){category in
                            Text("\(category.title)")
                                .tag(category.title)
                        }
                    }
                    
                    
                    HStack{
                        Button{
                            showImagePicker = true
                        }label: {
                            HStack{
                                Spacer()
                                VStack(spacing: 8){
                                    Image(systemName: "camera.fill")
                                        .font(.title2)
                                    Text("Foto elave et")
                                }
                                .foregroundColor(.blue)
                                Spacer()
                            }
                            .padding(.vertical,10)
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                  
                }
                Section{
                    TextField("Qiymet, AZN", value: $priceOfProduct ,format: .number)
                        .keyboardType(.decimalPad)
                    
                }
                Section{
                    TextField("Mehsulun Basligi", text: $titleOfProduct)
                   
                }
                Section("Haqqinda"){
                    TextEditor(text: $descriptinOfProduct)
                }
           
                Section{
                    HStack{
                        Spacer()
                        Button("Mehsulu elave et"){
                            // add product
                        }
                        .foregroundColor(.white)
                        .bold()
                        Spacer()
                    }
                    .listRowBackground(Color.accentColor)
                   
                }
                
                
                
                                                                    
                                           
                                        
                
            }
            .scrollContentBackground(.hidden)
            
            
        }
        .safeAreaInset(edge: .top) {
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
            .padding(.horizontal)
        }
    }
}

struct NewProductAddView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductAddView()
            .environmentObject(ProductsData())
    }
}
