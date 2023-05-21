//
//  TradeViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 19.05.2023.
//

import UIKit
import WebKit

final class TradeViewController: UIViewController, LabelTransferDelegate {

    private var stackViewBottomConstraint: NSLayoutConstraint?

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "131628")
        createNavBarItems()
        addSubviews()
        setConstraints()
        stackViewBottomConstraint = stackViewOfStacks.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        stackViewBottomConstraint?.isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }

    private func createNavBarItems() {
        navigationItem.title = "Trade"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hex: "131628")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 24, weight: .bold)
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
    }

    //    private lazy var scrollView: UIScrollView = {
    //        let scrollView = UIScrollView()
    //        scrollView.showsVerticalScrollIndicator = false
    //        scrollView.translatesAutoresizingMaskIntoConstraints = false
    //        return scrollView
    //    }()
    //
    //    private lazy var contentView: UIView = {
    //        let view = UIView()
    //        view.sizeToFit()
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()

    private lazy var balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "343748")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "C1C2C7")
        label.text = "Balance"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "10 000"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tradeChartView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .gray
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var currencyPairView: UIView = {
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
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var chooseCurrencyPairButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(goToPairs), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var timerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "343748")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "C1C2C7")
        label.text = "Timer"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var timerMinusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "minus.circle")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(hex: "C1C2C7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var timerTextField: UITextField = {
        let textField = UITextField()
        textField.text = "00:01"
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 19)
        textField.keyboardType = .numberPad
        setKeyboardSettings(forUITextField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var timerPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(hex: "C1C2C7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var investmentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "343748")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var investmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "C1C2C7")
        label.text = "Investment"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var investmentMinusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "minus.circle")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(hex: "C1C2C7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var investmentTextField: UITextField = {
        let textField = UITextField()
        textField.text = "1,000"
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 19)
        textField.keyboardType = .numberPad
        setKeyboardSettings(forUITextField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var investmentPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(hex: "C1C2C7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var sellButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = UIColor(hex: "EA4F4C")
        button.configuration?.title = "Sell"
        button.configuration?.attributedTitle?.font = .systemFont(ofSize: 26)
        button.contentHorizontalAlignment = .leading
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = UIColor(hex: "60B678")
        button.configuration?.title = "Buy"
        button.configuration?.attributedTitle?.font = .systemFont(ofSize: 26)
        button.contentHorizontalAlignment = .leading
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var stackViewOfBalanceView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackViewOfTwoViews: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 11
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackViewOfTwoButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 11
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackViewOfTimerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackViewOfInvestmentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackViewOfStacks: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    //MARK: - Methods
    private func addSubviews() {
        //        view.addSubview(scrollView)
        //        scrollView.addSubview(contentView)
        balanceView.addSubview(stackViewOfBalanceView)
        timerView.addSubview(stackViewOfTimerView)
        investmentView.addSubview(stackViewOfInvestmentView)
        [timerLabel].forEach { timerView.addSubview($0) }
        [investmentLabel].forEach { investmentView.addSubview($0) }
        [currencyPairLabel, chooseCurrencyPairButton].forEach { currencyPairView.addSubview($0) }
        [balanceView, tradeChartView, stackViewOfStacks].forEach { view.addSubview($0) }
        [balanceLabel, amountLabel].forEach { stackViewOfBalanceView.addArrangedSubview($0) }
        [timerView, investmentView].forEach { stackViewOfTwoViews.addArrangedSubview($0) }
        [sellButton, buyButton].forEach { stackViewOfTwoButtons.addArrangedSubview($0) }
        [timerMinusButton, timerTextField, timerPlusButton].forEach { stackViewOfTimerView.addArrangedSubview($0) }
        [investmentMinusButton, investmentTextField, investmentPlusButton].forEach { stackViewOfInvestmentView.addArrangedSubview($0) }
        [currencyPairView, stackViewOfTwoViews, stackViewOfTwoButtons].forEach { stackViewOfStacks.addArrangedSubview($0) }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            //            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            //            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            //
            //            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            //            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            //            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            //            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            //            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 100),

            balanceView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            balanceView.heightAnchor.constraint(equalToConstant: 54),

            stackViewOfBalanceView.centerXAnchor.constraint(equalTo: balanceView.centerXAnchor),
            stackViewOfBalanceView.centerYAnchor.constraint(equalTo: balanceView.centerYAnchor),

            tradeChartView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 25),
            tradeChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tradeChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tradeChartView.heightAnchor.constraint(equalToConstant: 320),

            stackViewOfStacks.topAnchor.constraint(equalTo: tradeChartView.bottomAnchor, constant: 16),
            stackViewOfStacks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackViewOfStacks.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            currencyPairView.heightAnchor.constraint(equalToConstant: 54),

            currencyPairLabel.centerXAnchor.constraint(equalTo: currencyPairView.centerXAnchor),
            currencyPairLabel.centerYAnchor.constraint(equalTo: currencyPairView.centerYAnchor),

            chooseCurrencyPairButton.trailingAnchor.constraint(equalTo: currencyPairView.trailingAnchor, constant: -19),
            chooseCurrencyPairButton.centerYAnchor.constraint(equalTo: currencyPairView.centerYAnchor),
            chooseCurrencyPairButton.heightAnchor.constraint(equalToConstant: 20),

            timerView.heightAnchor.constraint(equalToConstant: 54),
            timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: timerView.topAnchor, constant: 5),

            stackViewOfTimerView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 1),
            stackViewOfTimerView.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),

            investmentView.heightAnchor.constraint(equalToConstant: 54),
            investmentLabel.centerXAnchor.constraint(equalTo: investmentView.centerXAnchor),
            investmentLabel.topAnchor.constraint(equalTo: investmentView.topAnchor, constant: 5),

            stackViewOfInvestmentView.topAnchor.constraint(equalTo: investmentLabel.bottomAnchor, constant: 1),
            stackViewOfInvestmentView.centerXAnchor.constraint(equalTo: investmentView.centerXAnchor),

            sellButton.heightAnchor.constraint(equalToConstant: 54),
            buyButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    @objc private func goToPairs() {
        let vc = CurrencyPairViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height
        stackViewBottomConstraint?.constant = -keyboardHeight - 16
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardDidHide(notification: Notification) {
        stackViewBottomConstraint?.constant = -16
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func transferLabel(withText text: String) {
        currencyPairLabel.text = text
    }
}

//MARK: - Extension
extension TradeViewController: UITextFieldDelegate {
    private func setKeyboardSettings(forUITextField textField: UITextField) {
        textField.delegate = self
        textField.autocorrectionType = .no
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapOnView)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
