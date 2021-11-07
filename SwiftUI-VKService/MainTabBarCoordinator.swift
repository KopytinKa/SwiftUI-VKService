//
//  MainTabBarCoordinator.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import UIKit
import Combine
import SwiftUI

class MainTabBarCoordinator {
    
    let navigationController: UINavigationController
    private let loginViewModel: LoginViewModel = LoginViewModel()
    private let apiVKService: VKService = VKService()
    private let realmService: RealmService = RealmService()
    private var cancellables: Set<AnyCancellable> = []
    
    init(navigationController: UINavigationController) {
        let loginView = LoginView(viewModel: loginViewModel, isUserLoggedIn: .constant(false))
        let loginViewController = UIHostingController(rootView: loginView)
        self.navigationController = UINavigationController(rootViewController: loginViewController)
    }
    
    public func start() {
        loginViewModel.$isUserLoggedIn.subscribe(on: RunLoop.main).sink { [weak self] isUserLoggedIn in
            guard let self = self else { return }
            if !isUserLoggedIn {
                self.navigationController.popToRootViewController(animated: true)
            } else {
                let mainTabBarViewController = self.createMainTabBarViewController()
                self.navigationController.pushViewController(mainTabBarViewController, animated: true)
            }
        }.store(in: &cancellables)
    }
    
    private func createMainTabBarViewController() -> UITabBarController {
        let friendsVC = createFriendsViewController()
        friendsVC.tabBarItem.image = UIImage(systemName: "person.circle")
        friendsVC.tabBarItem.title = "Друзья"
        let navVC = configuredNavigationController(rootViewController: friendsVC)
        
        let groupsVC = createGroupsViewController()
        groupsVC.tabBarItem.image = UIImage(systemName: "person.3")
        groupsVC.tabBarItem.title = "Группы"
        let navSecondVC = configuredNavigationController(rootViewController: groupsVC)
        
        let newsVC = createNewsViewController()
        newsVC.tabBarItem.image = UIImage(systemName: "newspaper")
        newsVC.tabBarItem.title = "Новости"
        let navThirdVC = configuredNavigationController(rootViewController: newsVC)

        let tabBarVC = self.configuredTabBarController
        tabBarVC.viewControllers = [navVC, navSecondVC, navThirdVC]
        
        return tabBarVC
    }
    
    private func createFriendsViewController() -> UIViewController {
        let friendsVC = FriendsView(viewModel: FriendViewModel(apiVKService: apiVKService, realmService: realmService))
        return UIHostingController(rootView: friendsVC)
    }
    
    private func createGroupsViewController() -> UIViewController {
        let groupsVC = GroupsView(viewModel: GroupViewModel(apiVKService: apiVKService, realmService: realmService))
        return UIHostingController(rootView: groupsVC)
    }
    
    private func createNewsViewController() -> UIViewController {
        let newsVC = NewsView()
        return UIHostingController(rootView: newsVC)
    }
                                   
    private func configuredNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }

    private lazy var configuredTabBarController: UITabBarController = {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.isTranslucent = false
        return tabBarVC
    }()
}
