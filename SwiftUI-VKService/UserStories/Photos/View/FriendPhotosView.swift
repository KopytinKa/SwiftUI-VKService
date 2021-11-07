//
//  FriendPhotosView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 13.10.2021.
//

import SwiftUI

struct FriendPhotosView: View {
    @ObservedObject var viewModel: PhotoViewModel
    
    let columns = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity))
    ]

    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center, spacing: 16)  {
                    if let photos = self.viewModel.displayItems {
                        ForEach(photos) { photo in
                            FriendPhotoCellView(photo: photo)
                                .frame(height: geometry.size.width/3)
                        }
                    }
                }
            }
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
