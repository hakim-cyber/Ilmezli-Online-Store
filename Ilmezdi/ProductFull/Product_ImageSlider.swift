//
//  Product_ImageSlider.swift
//  Ilmezdi
//
//  Created by aplle on 7/9/23.
//

import SwiftUI

struct Product_ImageSlider: View {
    var images:[Image]
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Product_ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        Product_ImageSlider(images: [Image(uiImage: UIImage()),Image(uiImage: UIImage()),Image(uiImage: UIImage()),Image(uiImage: UIImage())])
    }
}
