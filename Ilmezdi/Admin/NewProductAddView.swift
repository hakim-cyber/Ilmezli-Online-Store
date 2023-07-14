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
    
    @State private var adding = false
    
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
                            
                            addProduct{
                                dismiss()
                            }
                        }
                        .foregroundColor(.white)
                        .bold()
                        .disabled(categoryOfProduct == ""  || imagesArray == [] || priceOfProduct == nil || descriptinOfProduct == "" || adding)
                        Spacer()
                    }
                    .listRowBackground( categoryOfProduct == ""  || imagesArray == [] || priceOfProduct == nil || descriptinOfProduct == "" ? Color.secondary :  Color.accentColor)
                   
                }
             
                
             
                
                
                                                                    
                                           
                                        
                
            }
            .scrollDismissesKeyboard(.immediately)
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $showImagePicker){
                ImagePicker(imagesArray: $imagesArray)
            }
            .onAppear{
                categoryOfProduct = productData.categories[1].title ?? ""
            }
            .disabled(adding)
            .blur(radius: adding ? 5 : 0)
            
            
            if adding{
                ProgressView()
                    .scaleEffect(3)
                    .tint(Color.accentColor)
                    
            }
            
        }
       
       
        
    }
    func addProduct(completion:@escaping ()->Void){
        self.adding = true
        var images:[String] = []
        for image in imagesArray{
            images.append( productData.imageToString(image: image))
        }
       
            let product = Product(id: UUID().uuidString, name: titleOfProduct, description: descriptinOfProduct, images: images, category: categoryOfProduct, price: priceOfProduct ?? 0.0, postDate: productData.dateToString(date: Date.now))
        Task{
            do{
                try await  productData.addNewProduct(product: product){
                    self.adding = false
                    completion()
                }
                
            }catch{
                print(error)
                self.adding = false
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
