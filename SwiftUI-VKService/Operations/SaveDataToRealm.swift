//
//  SaveDataToRealm.swift
//  VKClient
//
//  Created by Кирилл Копытин on 09.08.2021.
//

import Foundation

class SaveDataToRealm: Operation {
    let realmService = RealmService()
    
    override func main() {
        guard let parseData = dependencies.first as? ParseFriendsData else { return }
        
        let models = parseData.outputData
        self.realmService.add(models: models)
    }
}
