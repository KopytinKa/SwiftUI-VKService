//
//  LoginService.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 12.10.2021.
//

import Foundation

import Foundation

class LoginService {
    let correctLogin = "1"
    let correctPassword = "1"
    
    func checkUserData(login: String, password: String) -> Bool {
        if login == correctLogin && password == correctPassword {
            return true
        } else {
            return false
        }
    }
}
