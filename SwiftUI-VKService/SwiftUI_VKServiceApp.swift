//
//  SwiftUI_VKServiceApp.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 04.10.2021.
//

import SwiftUI
import Firebase

@main
struct SwiftUI_VKServiceApp: App {
    let realmService = RealmService()
    let apiVKService = VKService()
    
    init() {
      FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.realmService)
                .environmentObject(self.apiVKService)
        }
    }
}
