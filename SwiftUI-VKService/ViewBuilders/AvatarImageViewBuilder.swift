//
//  AvatarImageViewBuilder.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 08.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct AvatarImage: View {
    var content: WebImage
    
    init(@ViewBuilder content: () -> WebImage) {
        self.content = content()
    }
    
    var body: some View {
        content
            .resizable()
            .frame(width: 30, height: 30)
            .cornerRadius(15)
            .modifier(CircleShadow(shadowColor: .black, shadowRadius: 4, shadowOpacity: 0.7))
            .padding()
    }
}
