//
//  GroupViewModel.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import Foundation
import Combine
import RealmSwift
import CoreData

class GroupViewModel: ObservableObject {
    private let apiVKService: VKService
    private let realmService: RealmService
    
    private(set) var groups: Results<GroupModel>?
    private var notificationToken: NotificationToken?
    
    let objectWillChange = ObjectWillChangePublisher()
    
    var displayItems: [GroupDisplayItem] = []
    @Published var error: Error?
    @Published var isErrorAlertPresented = false
    
    init(apiVKService: VKService, realmService: RealmService) {
        self.apiVKService = apiVKService
        self.realmService = realmService
    }
    
    func onAppear() {
        self.fetchGroups()
        self.realmLiveDataObserver()
    }
    
    // MARK: - Private
    
    private func fetchGroups() {
        self.apiVKService.getGroupsList(by: nil)
    }
    
    private func realmLiveDataObserver() {
        self.groups = realmService.realm.objects(GroupModel.self)
        
        self.notificationToken = self.groups?.observe { [weak self] changes in
            switch changes {
            case .initial(let items):
                self?.makeGroupDisplayItems(from: items)
            case .update(let items, _, _, _):
                self?.makeGroupDisplayItems(from: items)
            case .error(let error):
                self?.error = error
                self?.isErrorAlertPresented = true
            }
        }
    }
    
    private func makeGroupDisplayItems(from items: Results<GroupModel>) {
        self.displayItems = GroupDisplayItemFabric.makeItems(with: items)
        self.objectWillChange.send()
    }
}
