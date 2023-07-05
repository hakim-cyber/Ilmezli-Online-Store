//
//  Ilmezli logo.swift
//  Ilmezdi
//
//  Created by aplle on 7/5/23.
//

import SwiftUI

struct Ilmezli_logo: View {
    let font:Double
    var body: some View {
        Text("İLMƏZLI")
            .font(.custom("American Typewriter", size: font))
            .tracking(5)
    }
}

struct Ilmezli_logo_Previews: PreviewProvider {
    static var previews: some View {
        Ilmezli_logo(font: 40.0)
    }
}
