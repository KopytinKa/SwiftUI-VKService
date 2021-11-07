//
//  Session.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.11.2021.
//

import Foundation

final class Session {
    static let shared = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: String = ""
}
