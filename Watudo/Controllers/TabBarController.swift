//
//  TabBarController.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 19/12/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    let uiTabBar = UITabBar()
    let tabBarAppearance = UITabBarAppearance()
    
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = WColors.background
        
        tabBar.isTranslucent = true
        delegate = self
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        tabBarAppearance.backgroundColor = WColors.background
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: WColors.foreground!]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray2]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray2
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = WColors.foreground!
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        configureVCs()
    }
    
    private func configureVCs() {
        let todayVC = TodayViewController()
        let reportsVC = ReportsViewController()
        let profileVC = ProfileViewController()
        
        user.name = "Watudo User"
        
        todayVC.setVC(user: user)
        reportsVC.setVC(user: user)
        profileVC.setVC(user: user)
        
        viewControllers = [
            configureTabBar(for: todayVC, title: "Today", image: UIImage(systemName: "house.fill")!),
            configureTabBar(for: reportsVC, title: "Reports", image: UIImage(systemName: "chart.pie.fill")!),
            configureTabBar(for: profileVC, title: "Profile", image: UIImage(systemName: "person.fill")!)
        ]
    }
    
    private func configureTabBar(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
            
            UIView.transition(with: tabBar, duration: 0.3, options: [.transitionCrossDissolve]) { }
        }
        
        return true
        
    }
    
}
