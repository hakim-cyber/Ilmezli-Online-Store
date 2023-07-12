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
    
    @State private var imagesArray:[UIImage?] = []
    
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
                        ForEach(productData.categories.filter{$0.title != "Hamısı"},id:\.title){category in
                            Text("\(category.title)")
                                .tag(category.title)
                        }
                    }
                    
                    if imagesArray.count < 3{
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
                        .listRowBackground(Color.gray.opacity(0.3) )
                    }
                   
                   
                  
                  
                }
                Section{
                    if imagesArray != []{
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                ForEach(imagesArray.indices,id: \.self){id in
                                    Image(uiImage: imagesArray[id] ?? UIImage())
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: (screen.width * 0.88) / 2,maxHeight: (screen.height * 0.38) / 2 )
                                        
                                }
                            }
                        }
                        
                    }
                    
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
                        .disabled(categoryOfProduct == ""  || imagesArray == [] || priceOfProduct == nil || descriptinOfProduct == "")
                        Spacer()
                    }
                    .listRowBackground( categoryOfProduct == ""  || imagesArray == [] || priceOfProduct == nil || descriptinOfProduct == "" ? Color.secondary :  Color.accentColor)
                   
                }
             
                
             
                
                
                                                                    
                                           
                                        
                
            }
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $showImagePicker){
                ImagePicker(imagesArray: $imagesArray)
            }
            .onAppear{
                categoryOfProduct = productData.categories.first?.title ?? ""
            }
            
        }
       
       
        
    }
    func uiimageToImage(uimages:[UIImage?])->[Image]{
        var images:[Image] = []
        for uimage in uimages {
            images.append(Image(uiImage: uimage ?? UIImage()))
        }
        return images
    }
}

struct NewProductAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NewProductAddView()
                .environmentObject(ProductsData())
        }
    }
}
