//
//  FriendCellView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.10.2021.
//

import SwiftUI

struct FriendCellView: View {
    let friend: Friend
    
    var body: some View {
        HStack {
            AvatarImage {
                Image("\(self.friend.avatar ?? "camera")")
            }
            
            VStack (alignment: .leading){
                Text("\(self.friend.getFullName())")
                
                Text("\(self.friend.company ?? ""), \(self.friend.city ?? "")")
                    .font(.footnote)
                    .fontWeight(.thin)
            }
            .lineLimit(1)

            Spacer()
        }
    }
}

struct FriendCellView_Previews: PreviewProvider {
    static var previews: some View {
        FriendCellView(friend: Friend(lastName: "Ivanov", firstName: "Ivan", avatar: nil, company: "QSOFT", city: "Moscow"))
    }
}
