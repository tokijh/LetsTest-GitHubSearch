//
//  SceneDelegate.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let repositorySearchService = GitHubRepositorySearchService()
        let viewModel = RepositoryListViewModel(repositorySearchService: repositorySearchService)
        let viewController = RepositoryListViewController(
            viewModel: viewModel
        )
        let navigationController: UINavigationController = {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.prefersLargeTitles = true
            return navigationController
        }()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}
