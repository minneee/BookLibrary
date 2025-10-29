//
//  SceneDelegate.swift
//  BookLibrary
//
//  Created by 김민희 on 10/24/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private var networkTest: NetworkTest?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: scene)
    window.rootViewController = createTabBarController()
    window.makeKeyAndVisible()
    self.window = window

    networkTest = NetworkTest()
    networkTest?.runTest()
  }

  private func createTabBarController() -> UITabBarController {
    let tabBarController = UITabBarController()

    let repository = BookRepository()
    let useCase = SearchBooksUseCase(repository: repository)
    let viewModel = SearchViewModel(useCase: useCase)
    let searchVC = UINavigationController(rootViewController: SearchViewController(viewModel: viewModel))
    let savedBookListVC = UINavigationController(rootViewController: SavedBookListViewController())

    searchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
    savedBookListVC.tabBarItem = UITabBarItem(title: "담은 책", image: UIImage(systemName: "book"), tag: 1)

    tabBarController.viewControllers = [searchVC, savedBookListVC]
    tabBarController.tabBar.barTintColor = .systemBlue

    return tabBarController
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }


}

