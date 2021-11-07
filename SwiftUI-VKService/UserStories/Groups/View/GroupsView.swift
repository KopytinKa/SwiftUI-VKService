//
//  GroupsView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 12.10.2021.
//

import SwiftUI

struct GroupsView: View {
    @ObservedObject var viewModel: GroupViewModel
    
    var body: some View {
        List(self.viewModel.displayItems.sorted(by: { $0.name < $1.name}), rowContent: { group in
            GroupCellView(group: group)
        })
        .listStyle(.plain)
        .onAppear(perform: self.viewModel.onAppear)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(viewModel: GroupViewModel(apiVKService: VKService(), realmService: RealmService()))
    }
}
