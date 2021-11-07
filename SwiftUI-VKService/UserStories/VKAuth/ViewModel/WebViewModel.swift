//
//  WebViewModel.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.11.2021.
//

import SwiftUI

class WebViewModel: ObservableObject {
    @Published var shouldRedirectToLoginView: Bool = false
}
