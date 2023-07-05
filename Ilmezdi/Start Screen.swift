//
//  Start Screen.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct Start_Screen: View {
    @State private var goToMain = false
    var body: some View {
        if goToMain{
            ContentView()
        }else{
            ZStack{
                Color("background").ignoresSafeArea()
                Ilmezli_logo(font: 40)
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5){
                    withAnimation(.easeInOut){
                        goToMain = true
                    }
                }
            }
        }
    }
}

struct Start_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Start_Screen()
    }
}
