//
//  CircleShadowViewModifier.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.10.2021.
//

import SwiftUI

struct CircleShadow: ViewModifier {
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowOpacity: Double
    
    func body(content: Content) -> some View {
        content
            .background(Circle()
                .fill(Color.white)
                            .shadow(color: shadowColor.opacity(shadowOpacity), radius: shadowRadius))
    }
}
