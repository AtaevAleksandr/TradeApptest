//
//  TradeViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 19.05.2023.
//

import UIKit
import WebKit

final class TradeViewController: UIViewController, LabelTransferDelegate, WKNavigationDelegate, CurrencyPairSelectionDelegate {

    private var stackViewBottomConstraint: NSLayoutConstraint?
    var betAmount = 1000 {
        didSet {
            investmentTextField.text = "\(betAmount)"
        }
    }
    let htmlString = HTMLUrl.htmlString

    var selectedPair: CurrencyPair?
    var currencyPairs = CurrencyPair.currencyPairs

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "131628")
        createNavBarItems()
        addSubviews()
        setConstraints()
        stackViewBottomConstraint = stackViewOfStacks.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13)
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

    //MARK: - Clousers
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
        label.text = "10000"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tradeChartView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .gray
        view.clipsToBounds = true
        view.navigationDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loadHTMLString(htmlString, baseURL: nil)
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
        label.text = "EUR / USD"
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
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var timerTextField: UITextField = {
        let textField = UITextField()
        textField.text = "00:00"
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 19)
        textField.keyboardType = .numberPad
        textField.text = String(format: "%02d:%02d")
        textField.tag = 0
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        setKeyboardSettings(forUITextField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var timerPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(hex: "C1C2C7")
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var investmentTextField: UITextField = {
        let textField = UITextField()
        textField.text = "1000"
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 19)
        textField.keyboardType = .numberPad
        textField.tag = 1
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        setKeyboardSettings(forUITextField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var investmentPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(hex: "C1C2C7")
        button.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(sellButtonTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
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
        stackViewBottomConstraint?.constant = -keyboardHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardDidHide(notification: Notification) {
        stackViewBottomConstraint?.constant = -13
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func transferLabel(withText text: String) {
        print(#function)
        currencyPairLabel.text = text
    }

    func updateWebView() {
        print(#function)
        guard let selectedCurrencyPair = currencyPairs.first(where: { $0.symbol == selectedPair?.symbol }) else {
            return
        }
        print(selectedCurrencyPair.symbol)

        let urlString = "https://www.tradingview.com/chart/?symbol=FX%3A\(selectedCurrencyPair.symbol)"
        print(urlString)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            tradeChartView.load(request)
        }
        tradeChartView.reload()
    }

    func didSelect(currencyPairSymbol: String) {
        print(#function)
//        print(selectedPair?.symbol ?? "HUI")
//        selectedPair?.symbol = currencyPairSymbol
        updateWebView()
//        print(currencyPairSymbol)
    }

    @objc private func minusButtonTapped() {
        let timeComponents = timerTextField.text!.split(separator: ":")
        var minutes = Int(timeComponents[0])!
        var seconds = Int(timeComponents[1])!
        if seconds == 0 && minutes == 1 {
            seconds = 59
            minutes = 0
        } else if seconds == 0 && minutes > 0 {
            seconds = 59
            minutes -= 1
        } else if seconds == 0 && minutes == 0 {
            minutes = 0
            seconds = 0
        } else {
            seconds -= 1
        }
        timerTextField.text = String(format: "%02d:%02d", minutes, seconds)
    }

    @objc private func plusButtonTapped() {
        let timeComponents = timerTextField.text!.split(separator: ":")
        var minutes = Int(timeComponents[0])!
        var seconds = Int(timeComponents[1])!
        if seconds == 59 && minutes == 59 {
            seconds = 0
            minutes = 0
        } else if seconds == 59 {
            seconds = 0
            minutes += 1
        } else {
            seconds += 1
        }
        timerTextField.text = String(format: "%02d:%02d", minutes, seconds)
    }

    @objc private func minusTapped() {
        if betAmount > 0 {
            betAmount -= 100
        }
        if betAmount == 0 {
            betAmount = 0
        }
    }

    @objc private func plusTapped() {
        betAmount += 100
        if let scoreText = amountLabel.text, let betText = investmentTextField.text {
            if let score = Int(scoreText), let bet = Int(betText) {
                if bet > score {
                    showAlert()
                }
            } else {
                print("One or both values are not integers")
            }
        } else {
            print("One or both values are nil")
        }
    }

    @objc private func sellButtonTapped() {
        let success = Bool.random()
        if let scoreText = amountLabel.text, let betText = investmentTextField.text {
            if var score = Int(scoreText), let bet = Int(betText) {
                if bet > score {
                    showAlert()
                } else if score == 0 {
                    showAlert()
                    amountLabel.text = "\(score)"
                }
                if success {
                    score += Int(Double(bet) * 1.7)
                    let alert = UIAlertController(title: "Success!", message: "The bet has been successfully sold. Balance: \(score)", preferredStyle: .alert)
                    amountLabel.text = "\(score)"
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Failure!", message: "The bet is not sold. Balance: \(score)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                print("One or both values are not integers")
            }
        } else {
            print("One or both values are nil")
        }
    }

    @objc private func buyButtonTapped() {
        let success = Bool.random()
        if let scoreText = amountLabel.text, let betText = investmentTextField.text {
            if var score = Int(scoreText), let bet = Int(betText) {
                if bet > score {
                    showAlert()
                } else if score == 0 {
                    showAlert()
                    amountLabel.text = "\(score)"
                }
                if success {
                    score -= bet
                    let alert = UIAlertController(title: "Success!", message: "The bet has been successfully purchased. Balance: \(score)", preferredStyle: .alert)
                    amountLabel.text = "\(score)"
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Failure!", message: "The bet is not purchased. Balance: \(score)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    @objc internal func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            timerView.layer.borderWidth = 1
            timerView.layer.borderColor = UIColor(hex: "60B678")?.cgColor
        } else if textField.tag == 1 {
            investmentView.layer.borderWidth = 1
            investmentView.layer.borderColor = UIColor(hex: "60B678")?.cgColor
        }
    }

    @objc internal func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            timerView.layer.borderWidth = 0
            timerView.layer.borderColor = UIColor.clear.cgColor
        } else if textField.tag == 1 {
            investmentView.layer.borderWidth = 0
            investmentView.layer.borderColor = UIColor.clear.cgColor
        }
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

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, let amount = Int(text) {
            betAmount = amount
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.tag == 0 {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            guard characterSet.isSubset(of: allowedCharacters) else {
                return false
            }

            let components = newText.components(separatedBy: ":")
            if components.count > 2 {
                return false
            }
            if components.count == 2 {
                if components[0].count > 2 || components[1].count > 2 {
                    return false
                }
                if let minutes = Int(components[0]), let seconds = Int(components[1]), minutes < 60 && seconds < 60 {
                    return true
                } else {
                    return false
                }
            }
            if let minutes = Int(newText), minutes < 60 {
                return true
            } else {
                return false
            }
        } else if textField.tag == 1 {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 5
        }
        return true
    }
    private func showAlert() {
        let alertController = UIAlertController(title: "Attention!",
                                                message: "You don't have enough money! :(", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion:nil)
        dismissKeyboard()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
