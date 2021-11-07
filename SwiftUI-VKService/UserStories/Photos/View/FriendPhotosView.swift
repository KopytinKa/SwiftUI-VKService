//
//  FriendPhotosView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 13.10.2021.
//

import SwiftUI
import ASCollectionView

struct FriendPhotosView: View {
    @ObservedObject var viewModel: PhotoViewModel
    
    var body: some View {
        ASCollectionView(data: self.viewModel.displayItems) { photo, _ in
            FriendPhotoCellView(photo: photo)
        }.layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(3),
                itemSpacing: 0,
                lineSpacing: 16
            )
        }
        .navigationTitle(self.viewModel.friend.fullName)
        .onAppear(perform: self.viewModel.onAppear)
    }
}

struct FriendPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotosView(viewModel: PhotoViewModel(friend: FriendDisplayItem(id: 1, fullName: "Ivan Ivanov", avatar: "", userInfo: "Moscow"), apiVKService: VKService(), realmService: RealmService()))
    }
}
