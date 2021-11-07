//
//  FriendViewModel.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.11.2021.
//

import Foundation
import Combine
import RealmSwift
import CoreData

class FriendViewModel: ObservableObject {
    private let apiVKService: VKService
    private let realmService: RealmService
    
    private(set) var friends: Results<UserModel>?
    private var notificationToken: NotificationToken?
    
    let objectWillChange = ObjectWillChangePublisher()
    
    var displayItems: [FriendDisplayItem] = []
    @Published var error: Error?
    @Published var isErrorAlertPresented = false
    
    init(apiVKService: VKService, realmService: RealmService) {
        self.apiVKService = apiVKService
        self.realmService = realmService
    }
    
    func onAppear() {
        self.fetchFriends()
        self.realmLiveDataObserver()
    }
    
    // MARK: - Private
    
    private func fetchFriends() {
        self.apiVKService.getFriendsList(by: nil)
    }
    
    private func realmLiveDataObserver() {
        self.friends = realmService.realm.objects(UserModel.self)
        
        self.notificationToken = self.friends?.observe { [weak self] changes in
            switch changes {
            case .initial(let items):
                self?.makeFriendDisplayItems(from: items)
            case .update(let items, _, _, _):
                self?.makeFriendDisplayItems(from: items)
            case .error(let error):
                self?.error = error
                self?.isErrorAlertPresented = true
            }
        }
    }
    
    private func makeFriendDisplayItems(from items: Results<UserModel>) {
        self.displayItems = FriendDisplayItemFabric.makeItems(with: items)
        self.objectWillChange.send()
    }
}
