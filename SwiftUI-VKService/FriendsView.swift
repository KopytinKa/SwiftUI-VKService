//
//  FriendsView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 12.10.2021.
//

import SwiftUI

struct FriendsView: View {
    @State private var friends: [Friend] = [
        Friend(lastName: "Ivanov", firstName: "Ivan", avatar: nil, company: "QSOFT", city: "Moscow"),
        Friend(lastName: "Petrov", firstName: "Petr", avatar: "community", company: "mail.ru", city: "Kazan"),
        Friend(lastName: "Vasiliev", firstName: "Vasiliy", avatar: nil, company: "yandex", city: nil),
        Friend(lastName: "Vasiliev", firstName: "Kirill", avatar: nil, company: "yandex", city: nil),
        Friend(lastName: "Vasiliev", firstName: "Petr", avatar: nil, company: "yandex", city: nil),
        Friend(lastName: "Vasiliev", firstName: "Ivan", avatar: nil, company: "yandex", city: nil),
        Friend(lastName: "Kirillov", firstName: "Kirill", avatar: nil, company: nil, city: "Moscow")
    ]
    
    var body: some View {
        List(arrayLetter(), rowContent: { section in
            Section(header: Text("\(section.letter)")) {
                ForEach(arrayByLetter(section.letter)) { friend in
                    NavigationLink(destination: FriendPhotosView(friend: friend)) {
                        FriendCellView(friend: friend)
                    }
                }
            }
        })
        .listStyle(.plain)
    }
    
    private func arrayLetter() -> [SectionDataModel] {
        var resultArray = [SectionDataModel]()
        
        for friend in friends {
            let nameLetter = String(friend.lastName.prefix(1))
            let letterModel = SectionDataModel(letter: nameLetter)
            if !resultArray.contains(letterModel) {
                resultArray.append(letterModel)
            }
        }
        
        resultArray = resultArray.sorted(by: { $0.letter < $1.letter })
        
        return resultArray
    }
    
    private func arrayByLetter(_ letter: String) -> [Friend] {
        var resultArray = [Friend]()
        
        for friend in friends {
            let nameLetter = String(friend.lastName.prefix(1))
            if nameLetter == letter {
                resultArray.append(friend)
            }
        }
        
        return resultArray
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
