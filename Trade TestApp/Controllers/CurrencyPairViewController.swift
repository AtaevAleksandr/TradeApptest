//
//  CurrencyPairViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 21.05.2023.
//

import UIKit

class CurrencyPairViewController: UIViewController, UIGestureRecognizerDelegate {

    var currencyPairs = CurrencyPair.currencyPairs
    weak var delegate: LabelTransferDelegate?
    var selectedPair: CurrencyPair?
    weak var delegatePair: CurrencyPairSelectionDelegate?
    var selectedIndexPath: IndexPath?

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "131628")
        createNavBarItems()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        setConstraints()
    }

    //MARK: - Clousers
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.estimatedItemSize = .zero

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CurrencyPairCollectionViewCell.self, forCellWithReuseIdentifier: Cell.collectionViewCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    //MARK: Methods
    private func createNavBarItems() {
        navigationItem.title = "Currency pair"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hex: "131628")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 24, weight: .bold)
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        let navigationBackButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.setLeftBarButton(navigationBackButton, animated: true)
        navigationBackButton.tintColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension CurrencyPairViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currencyPairs.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 37) / 2, height: 54)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.collectionViewCell, for: indexPath) as! CurrencyPairCollectionViewCell
        let pairs = currencyPairs[indexPath.item]
        cell.setName(pairs)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPair = currencyPairs[indexPath.item]
        delegate?.transferLabel(withText: selectedPair!.name)

        if let selectedIndexPath = selectedIndexPath {
            if let cell = collectionView.cellForItem(at: selectedIndexPath) as? CurrencyPairCollectionViewCell {
                cell.currencyPairView.backgroundColor = UIColor(hex: "343748")
            }
        }

        if let cell = collectionView.cellForItem(at: indexPath) as? CurrencyPairCollectionViewCell {
            cell.currencyPairView.backgroundColor = UIColor(hex: "60B678")
        }
        selectedIndexPath = indexPath


        guard let selectedPair = selectedPair else { return }
        delegatePair?.didSelect(currencyPairSymbol: selectedPair.symbol)
        navigationController?.popViewController(animated: true)
    }
}
