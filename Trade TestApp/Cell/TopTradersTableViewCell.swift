//
//  TopTradersTableViewCell.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 20.05.2023.
//

import UIKit

final class TopTradersTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Clousers
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackViewOfTwoUIEl: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "C1C2C7")
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var depositLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var profitLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "60B678")
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Methods
    private func addSubviews() {
        addSubview(stackView)
        [stackViewOfTwoUIEl, nameLabel, depositLabel, profitLabel].forEach { stackView.addArrangedSubview($0) }
        [numberLabel, countryLabel].forEach { stackViewOfTwoUIEl.addArrangedSubview($0) }

    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            stackViewOfTwoUIEl.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackViewOfTwoUIEl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackViewOfTwoUIEl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

        func set(_ elements: Trader) {
            numberLabel.text = "\(elements.number)"
            countryLabel.text = elements.country
            nameLabel.text = elements.name
            depositLabel.text = "$\(elements.deposit)"
            profitLabel.text = "$\(elements.profit)"
        }
}
