//
//  TopTradersViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 19.05.2023.
//

import UIKit

final class TopTradersViewController: UIViewController {
    
    var traders = Trader.traders
    
    struct Cell {
        static let cell = "TopTradersViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "1D1F2C")
        createNavBarItems()
        view.addSubview(tableView)
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let timer = Timer.scheduledTimer(withTimeInterval: 180, repeats: true) { timer in
            
            let randomIndex = Int.random(in: 1..<self.traders.count)


            let deposit = self.traders[randomIndex].deposit + Int.random(in: -150...50)
            let profit = self.traders[randomIndex].profit + Int.random(in: -150...50)

            self.traders[randomIndex].deposit = deposit
            self.traders[randomIndex].profit = profit

            let indexPath = IndexPath(row: randomIndex, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        timer.fire()
    }
    
    private func createNavBarItems() {
        navigationItem.title = "TOP 10 Traders"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hex: "1D1F2B")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 24, weight: .bold)
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.backgroundColor = UIColor(hex: "20222E")
        tabBarController?.tabBar.standardAppearance = tabAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabAppearance
        
    }
    
    private lazy var tableView: UITableView = {
        let tableViewList = UITableView(frame: .zero, style: .grouped)
        tableViewList.translatesAutoresizingMaskIntoConstraints = false
        tableViewList.register(TopTradersTableViewCell.self, forCellReuseIdentifier: Cell.cell)
        tableViewList.dataSource = self
        tableViewList.delegate = self
        tableViewList.backgroundColor = .clear
        tableViewList.showsVerticalScrollIndicator = false
        return tableViewList
    }()
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TopTradersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        traders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.cell) as! TopTradersTableViewCell
        cell.selectionStyle = .none
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(hex: "2E303D")
        } else {
            cell.backgroundColor = UIColor(hex: "1D1F2C")
        }
        let traders = traders[indexPath.row]
        if indexPath.row == 0 {
            cell.numberLabel.text = "№"
            cell.numberLabel.font = .systemFont(ofSize: 12)
            cell.countryLabel.text = "Country"
            cell.countryLabel.textColor = UIColor(hex: "C1C2C7")
            cell.countryLabel.font = .systemFont(ofSize: 12)
            cell.nameLabel.text = "Name"
            cell.nameLabel.textColor = UIColor(hex: "C1C2C7")
            cell.nameLabel.font = .systemFont(ofSize: 12)
            cell.depositLabel.text = "Deposit"
            cell.depositLabel.textColor = UIColor(hex: "C1C2C7")
            cell.depositLabel.font = .systemFont(ofSize: 12)
            cell.profitLabel.text = "Profit"
            cell.profitLabel.textColor = UIColor(hex: "C1C2C7")
            cell.profitLabel.font = .systemFont(ofSize: 12)
        } else {
            cell.set(traders)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let firstCellIndexPath = IndexPath(row: 0, section: 0)
        let lastCellIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        
        if indexPath == firstCellIndexPath {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath == lastCellIndexPath {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
            cell.layer.maskedCorners = []
        }
        
    }
}