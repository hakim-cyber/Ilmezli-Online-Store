//
//  NewProductAddView.swift
//  Ilmezdi
//
//  Created by aplle on 7/12/23.
//

import SwiftUI
import PhotosUI

enum ImageSource:String{
    case library,camera
}

struct NewProductAddView: View {
    var editingProduct:Product?
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showImagePicker = false
    @State private var showCapture = false
    @State private var screen = UIScreen.main.bounds
    
    @State private var imagesArray:[UIImage?] = []
    
    @State private var categoryOfProduct = ""
    @State private var titleOfProduct = ""
    @State private var descriptinOfProduct = ""
    @State private var priceOfProduct:Double?
    
  
    
    @State private var adding = false
    
    @EnvironmentObject var productData:ProductsData
    
    @FocusState private var focused:Bool
    @FocusState private var focusedDescription:Bool
    
    @State private var writingDescription = false
   
   
    
    var body: some View {
        NavigationStack{
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
                            
                            if imagesArray.count < 3{
                                HStack{
                                    
                                    Menu{
                                        Button{
                                           
                                            showImagePicker = true
                                        }label: {
                                            Text("Galeri")
                                            Image(systemName: "photo.artframe")
                                            
                                        }
                                        Button{
                                            
                                            showCapture = true
                                        }label: {
                                            Image(systemName: "camera.fill")
                                            Text("Camera")
                                        }
                                        
                                    }label: {
                                        HStack{
                                            Spacer()
                                            VStack(spacing: 8){
                                                Image(systemName: "camera.fill")
                                                    .font(.title2)
                                                Text("Foto əlavə et")
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
                                                .frame(width: 80)
                                                .cornerRadius(10)
                                            
                                                .overlay(alignment:.topTrailing){
                                                    Button{
                                                        withAnimation {
                                                            imagesArray.removeAll(where: {$0 == imagesArray[id]})
                                                        }
                                                    }label:{
                                                        Image(systemName: "xmark")
                                                            .font(.caption)
                                                            .foregroundColor(.red)
                                                            .bold()
                                                            .padding(8)
                                                            .background(Circle().fill(Color.gray.opacity(0.4)))
                                                    }
                                                    .padding(.vertical,5)
                                                    
                                                }
                                               
                                            
                                            
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        Section{
                            TextField("Qiymət, AZN", value: $priceOfProduct ,format: .number)
                                .keyboardType(.decimalPad)
                                .focused($focused)
                                .foregroundColor(.accentColor)
                            
                            
                            
                        }
                        Section{
                            TextField("Məhsulun Başlıgı", text: $titleOfProduct)
                                .focused($focused)
                            
                            
                        }
                        Section("Haqqında"){
                            TextEditor(text: $descriptinOfProduct)
                                .onTapGesture {
                                    self.writingDescription = true
                                    self.focusedDescription = true
                                }
                            
                                
                            
                            
                        }
                        
                        Section{
                            HStack{
                                Spacer()
                                Button("Məhsulu əlave et"){
                                    // add product
                                    if editingProduct == nil{
                                        addProduct{
                                            dismiss()
                                        }
                                    }else{
                                        saveEdit{
                                            dismiss()
                                        }
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
                    .scrollDismissesKeyboard(.interactively)
                    .scrollContentBackground(.hidden)
                    .sheet(isPresented: $showImagePicker){
                       
                            ImagePicker(imagesArray: $imagesArray)
                      
                    }
                    .sheet(isPresented: $showCapture){
                       
                     
                           
                        PhotoCapture(imagesArray: $imagesArray)
                          
                        
                      
                    }
                    .onAppear{
                        if editingProduct == nil{
                            categoryOfProduct = productData.categories[1].title ?? ""
                        }else{
                            
                            self.categoryOfProduct = editingProduct!.category
                            self.descriptinOfProduct = editingProduct!.description
                            self.imagesArray = StringsArrayToImage(strings: editingProduct?.images ?? [])
                            self.priceOfProduct = editingProduct?.price
                            self.titleOfProduct = editingProduct?.name ?? ""
                        }
                    }
                    .disabled(adding)
                    .blur(radius: adding ? 5 : 0)
                    
                    
                    
                    
                }
                .overlay(alignment:.center){
                    if adding{
                        ProgressView()
                            .scaleEffect(2)
                            .tint(Color.accentColor)
                        
                    }
                }
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                        
                        Spacer()
                        if !writingDescription{
                            Button("Tamam") {
                                
                                focused = false
                                
                                if self.writingDescription{
                                    self.writingDescription = false
                                }
                                
                            }
                        }
                        
                        
                        
                        
                    }
                }
            if writingDescription{
                VStack{
                    Spacer()
                    VStack{
                        HStack{
                            Button("Sil 🗑️"){
                                withAnimation(.easeInOut){
                                    self.descriptinOfProduct = ""
                                }
                            }
                            Spacer()
                            Text("Haqqında")
                                .fontWeight(.medium)
                            Spacer()
                            
                            Button("Tamam"){
                                
                                    self.writingDescription = false
                                    self.focused = false
                                
                            }
                        }
                        .padding(.top,10)
                        .padding(.horizontal,15)
                        TextEditor(text: $descriptinOfProduct)
                            .focused($focusedDescription)
                        Spacer()
                    }
                   
                }
                .frame(height: screen.height / 2.5)
                .transition(.move(edge: .bottom))
            }
            
        }
       
        
    }
    func saveEdit(completion:@escaping ()->Void){
        self.adding = true
        
        
        var images:[String] = []
        for image in imagesArray{
            images.append( productData.imageToString(image: image))
        }
       
        let product = Product(id: editingProduct!.id,recordId:editingProduct?.recordId , name: titleOfProduct, description: descriptinOfProduct, images: images, category: categoryOfProduct, price: priceOfProduct ?? 0.0, postDate: productData.dateToString(date: Date.now))
        Task{
            do{
                try await  productData.updateProduct(editedProduct: product){
                    self.adding = false
                    completion()
                }
                
            }catch{
                print(error)
                self.adding = false
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
    func StringsArrayToImage(strings:[String])->[UIImage?]{
        var images:[UIImage?] = []
        for string in strings{
            let data = Data(base64Encoded: string) ?? Data()
                       
                       let uiImage = UIImage(data: data) ?? UIImage()
            images.append(uiImage)
        }
        return images
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



