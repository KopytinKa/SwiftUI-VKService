//
//  FriendsView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 12.10.2021.
//

import SwiftUI

struct FriendsView: View {
    @EnvironmentObject var realmService: RealmService
    @EnvironmentObject var apiVKService: VKService
    
    @ObservedObject var viewModel: FriendViewModel
    
    var body: some View {
        List(arrayLetter(), rowContent: { section in
            Section(header: Text("\(section.letter)")) {
                ForEach(arrayByLetter(section.letter)) { friend in
                    NavigationLink {
                        LazyView {
                            FriendPhotosView(
                                viewModel: PhotoViewModel(
                                    friend: friend,
                                    apiVKService: self.apiVKService,
                                    realmService: self.realmService
                                )
                            )
                        }
                    } label: {
                        FriendCellView(friend: friend)
                    }
                }
            }
        })
        .listStyle(.plain)
        .onAppear(perform: self.viewModel.onAppear)
    }
    
    private func arrayLetter() -> [SectionDataModel] {
        var resultArray = [SectionDataModel]()
        
        for friend in self.viewModel.displayItems {
            let nameLetter = String(friend.fullName.prefix(1))
            let letterModel = SectionDataModel(letter: nameLetter)
            if !resultArray.contains(letterModel) {
                resultArray.append(letterModel)
            }
        }
        
        resultArray = resultArray.sorted(by: { $0.letter < $1.letter })
        
        return resultArray
    }
    
    private func arrayByLetter(_ letter: String) -> [FriendDisplayItem] {
        var resultArray = [FriendDisplayItem]()
        
        for friend in self.viewModel.displayItems {
            let nameLetter = String(friend.fullName.prefix(1))
            if nameLetter == letter {
                resultArray.append(friend)
            }
        }
        
        return resultArray
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(viewModel: FriendViewModel(apiVKService: VKService(), realmService: RealmService()))
    }
}
