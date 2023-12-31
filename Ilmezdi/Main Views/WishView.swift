//
//  WishView.swift
//  Ilmezdi
//
//  Created by aplle on 7/16/23.
//

import SwiftUI

struct WishView: View {
    @EnvironmentObject var vm:WishedProducts
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            ProductsGrid(showWished: true, showSearch: .constant(false))
        }
    }
}

struct WishView_Previews: PreviewProvider {
    static var previews: some View {
        WishView()
            .environmentObject(WishedProducts())
    }
}
