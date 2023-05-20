//
//  TradeViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 19.05.2023.
//

import UIKit

class TradeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "131628")
        createNavBarItems()
    }

    private func createNavBarItems() {
        navigationItem.title = "Trade"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes?[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

}
