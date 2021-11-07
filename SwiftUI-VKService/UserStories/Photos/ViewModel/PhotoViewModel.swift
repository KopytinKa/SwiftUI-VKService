//
//  PhotoViewModel.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import Foundation
import Combine
import RealmSwift
import CoreData

class PhotoViewModel: ObservableObject {
    let friend: FriendDisplayItem
    private let apiVKService: VKService
    private let realmService: RealmService
    
    private(set) var photos: Results<PhotoModel>?
    private var notificationToken: NotificationToken?
    
    let objectWillChange = ObjectWillChangePublisher()
    
    var displayItems: [PhotoDisplayItem] = []
    @Published var error: Error?
    @Published var isErrorAlertPresented = false
    
    init(friend: FriendDisplayItem, apiVKService: VKService, realmService: RealmService) {
        self.friend = friend
        self.apiVKService = apiVKService
        self.realmService = realmService
    }
    
    func onAppear() {
        self.fetchPhotos()
        self.realmLiveDataObserver()
    }
    
    // MARK: - Private
    
    private func fetchPhotos() {
        self.apiVKService.getPhotos(by: self.friend.id)
    }
    
    private func realmLiveDataObserver() {
        self.photos = realmService.realm.objects(PhotoModel.self).filter("ownerID == \(self.friend.id)")
        
        self.notificationToken = self.photos?.observe { [weak self] changes in
            switch changes {
            case .initial(let items):
                self?.makePhotoDisplayItems(from: items)
            case .update(let items, _, _, _):
                self?.makePhotoDisplayItems(from: items)
            case .error(let error):
                self?.error = error
                self?.isErrorAlertPresented = true
            }
        }
    }
    
    private func makePhotoDisplayItems(from items: Results<PhotoModel>) {
        self.displayItems = PhotoDisplayItemFabric.makeItems(with: items)
        self.objectWillChange.send()
    }
}
