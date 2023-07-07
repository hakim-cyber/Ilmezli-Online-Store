//
//  ProductFull_Ui.swift
//  Ilmezdi
//
//  Created by aplle on 7/7/23.
//

import SwiftUI

struct ProductFull_Ui: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var productData:ProductsData
    @ObservedObject var vm:ProductFull_ViewModel
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing:40){
                HStack(spacing:20){
                    Button{
                        
                    }label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Toggle("", isOn: $vm.product.IsWished)
                        .labelsHidden()
                        .toggleStyle(HeartToggleStyle(font: 22))
                    Button{
                        // Share
                        
                    }label: {
                        Image(systemName: "paperplane.circle")
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                    }
                    Cart_(font: 22, itemCount: 4)
                }
            
                if vm.images == []{
                                                Color.gray.opacity(0.3)
                        .frame(width: screen.width * 0.88,height: screen.height * 0.38)
                                                .overlay{
                                                    Text("No Image")
                                                    }
                                                .cornerRadius(7)
                                                                    
                                            }else{
                                            vm.images.first!
                                               .resizable()
                                               .scaledToFit()
                                              
                                               .background( Color.gray.opacity(0.3))
                                               .cornerRadius(7)
                                        }
            }
            
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.horizontal)
        }
    }
}

struct ProductFull_Ui_Previews: PreviewProvider {
    @State static var example =  Product(id: UUID().uuidString, name: "Ventilyator", description: "Cox guclu ventilyator. Ev Ucun Eladi. Isti Havalarda Lazim Olur", images: [], category:"Ev", price: 15.5, postDate:"2023-07-07 10:10:10 ")
    static var previews: some View {
        ProductFull_Ui(vm: ProductFull_ViewModel(product: $example))
            .environmentObject(ProductsData())
    }
}
