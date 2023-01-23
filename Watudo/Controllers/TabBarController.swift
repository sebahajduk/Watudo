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
        viewControllers = [
            configureTabBar(for: HomeViewController(), title: "Today", image: UIImage(systemName: "house.fill")!),
            configureTabBar(for: ReportsViewController(), title: "Reports", image: UIImage(systemName: "chart.pie.fill")!),
            configureTabBar(for: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person.fill")!)
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
        }
        
        return true
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}
