//
//  ContentView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 12.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldShowMainView: Bool = false
    
    @EnvironmentObject var realmService: RealmService
    @EnvironmentObject var apiVKService: VKService
    
    @ObservedObject var webViewModel: WebViewModel = WebViewModel()
    
    var body: some View {
        NavigationView {
            HStack {
                VKAuthView(model: webViewModel)
                
                NavigationLink(
                    destination: LoginView(viewModel: LoginViewModel(), isUserLoggedIn: $shouldShowMainView)
                        .navigationBarBackButtonHidden(true),
                    isActive: $webViewModel.shouldRedirectToLoginView,
                    label: {
                        EmptyView()
                    }
                )
                .navigationBarBackButtonHidden(true)

                NavigationLink(
                    destination:
                        TabView {
                            FriendsView(viewModel:
                                            FriendViewModel(
                                                apiVKService: self.apiVKService,
                                                realmService: self.realmService
                                            )
                            )
                                .tabItem {
                                    Image(systemName: "person.circle")
                                    Text("Друзья")
                                }
                            GroupsView(viewModel:
                                        GroupViewModel(
                                            apiVKService: self.apiVKService,
                                            realmService: self.realmService
                                        )
                            )
                                .tabItem {
                                    Image(systemName: "person.3")
                                    Text("Группы")
                                }
                            NewsView()
                                .tabItem {
                                    Image(systemName: "newspaper")
                                    Text("Новости")
                                }
                        }
                        .navigationBarBackButtonHidden(true),
                    isActive: $shouldShowMainView,
                    label: {
                        EmptyView()
                    }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
