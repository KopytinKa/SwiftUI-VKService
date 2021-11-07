//
//  GroupCellView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct GroupCellView: View {
    let group: GroupDisplayItem
    
    var body: some View {
        HStack {
            AvatarImage {
                WebImage(url: URL(string: self.group.avatar))
                    .placeholder(Image("community"))
            }

            Text("\(self.group.name)")
            
            Spacer()
        }
        .lineLimit(1)
    }
}

struct GroupCellView_Previews: PreviewProvider {
    static var previews: some View {
        GroupCellView(group: GroupDisplayItem(id: 1, name: "Любители котов", avatar: "camera"))
    }
}
