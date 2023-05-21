//
//  CurrencyPairCollectionViewCell.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 21.05.2023.
//

import UIKit

class CurrencyPairCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(currencyPairView)
        currencyPairView.addSubview(currencyPairLabel)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Clousers
    lazy var currencyPairView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "343748")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var currencyPairLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "RUB / USD"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Methods
    private func setConstraints() {
        NSLayoutConstraint.activate([
            currencyPairView.topAnchor.constraint(equalTo: topAnchor),
            currencyPairView.leadingAnchor.constraint(equalTo: leadingAnchor),
            currencyPairView.trailingAnchor.constraint(equalTo: trailingAnchor),
            currencyPairView.bottomAnchor.constraint(equalTo: bottomAnchor),

            currencyPairLabel.centerXAnchor.constraint(equalTo: currencyPairView.centerXAnchor),
            currencyPairLabel.centerYAnchor.constraint(equalTo: currencyPairView.centerYAnchor)
        ])
    }

    func set(_ elements: CurrencyPair) {
        currencyPairLabel.text = elements.pair
    }
}
