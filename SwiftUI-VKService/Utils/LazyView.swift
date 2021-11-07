//
//  LazyView.swift
//  GeekbrainsSwiftUI
//
//  Created by v.prusakov on 10/7/21.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        self.content()
    }
    
}
