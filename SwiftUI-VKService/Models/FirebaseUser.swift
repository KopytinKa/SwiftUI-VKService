//
//  FirebaseUser.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.11.2021.
//

import Foundation
import Firebase

class FirebaseUser {
    let id: String
    let ref: DatabaseReference?
    
    init(id: String) {
        self.ref = nil
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? String
        else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.id = id
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "id": id
        ]
    }
}
