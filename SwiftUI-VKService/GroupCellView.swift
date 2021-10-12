//
//  GroupCellView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.10.2021.
//

import SwiftUI

struct GroupCellView: View {
    var body: some View {
        HStack {
            AvatarImage {
                Image("community")
            }

            Text("Название сообщества")
            
            Spacer()
        }
    }
}

struct GroupCellView_Previews: PreviewProvider {
    static var previews: some View {
        GroupCellView()
    }
}
