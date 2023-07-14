//
//  Start Screen.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct Start_Screen: View {
    @State private var goToMain = false
    @EnvironmentObject var productsData:ProductsData
  
    var body: some View {
        if goToMain{
            ContentView()
        }else{
            ZStack{
                Color.gray.opacity(0.1).ignoresSafeArea()
                Ilmezli_logo(font: 40)
            }
            .onAppear{
                
            }
            .task {
                do{
                    try await productsData.readProducts()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()){
                        withAnimation(.easeInOut){
                            goToMain = true
                        }
                    }
                }catch{
                    print(error)
                }
            }
          
        }
    }
}

struct Start_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Start_Screen()
            .environmentObject(ProductsData())
            
    }
}
