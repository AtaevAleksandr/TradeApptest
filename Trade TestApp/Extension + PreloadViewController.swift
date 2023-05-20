//
//  Extension + PreloadViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 19.05.2023.
//

import Foundation
import UIKit

extension PreloadViewController {

    private func createFirstController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: TopTradersViewController())
        navigationController.tabBarItem = UITabBarItem(title: "Top", image: UIImage(systemName: "person.3.fill"), tag: 0)
        return navigationController
    }

    private func createSecondController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: TradeViewController())
        navigationController.tabBarItem = UITabBarItem(title: "Trade", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 1)
        return navigationController
    }

    func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createFirstController(), createSecondController()]
        tabBar.tabBar.layer.borderWidth = 0.6
        tabBar.tabBar.layer.borderColor = UIColor(hex: "2F3240")?.cgColor
        tabBar.tabBar.tintColor = UIColor(hex: "60B678")
        tabBar.tabBar.unselectedItemTintColor = .gray
        tabBar.navigationItem.hidesBackButton = true
        return tabBar
    }
}
