//
//  SceneDelegate.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 01/12/2022.
//

import UIKit
import IQKeyboardManagerSwift
import FacebookCore
import FacebookLogin

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navController = UINavigationController()

    let curreLogged = FirebaseManager.shared.user != nil ? true : false

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        if curreLogged {
            navController = UINavigationController(rootViewController: TabBarController())
        } else {
            navController = UINavigationController(rootViewController: WelcomeViewController())
        }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navController
        navController.popToRootViewController(animated: true)
        UINavigationBar.appearance().tintColor = .systemGray2

        window?.makeKeyAndVisible()

        if Defaults.shared.isDarkMode != nil {
            window?.overrideUserInterfaceStyle = Defaults.shared.isDarkMode! ? .dark : .light
        }

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false

        Settings.appID = "3517037301863277"
        Settings.isAutoLogAppEventsEnabled = true

        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }

    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }

        window.rootViewController = viewController

        UIView.transition(with: window,
                          duration: 0.3,
                          options: [.transitionFlipFromRight],
                          animations: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded.
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
    }

}
