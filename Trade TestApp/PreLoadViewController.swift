//
//  PreLoadViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 19.05.2023.
//

import UIKit

final class PreLoadViewController: UIViewController {

    public let image = UIImage(named: "Back")
    private var progress: Float = 0.0
    private var timer: Timer? = nil
    private let color = UIColor(hex: "60B678")

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()

        progressView.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    private lazy var backView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = self.image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.backgroundColor = .gray
        view.progressTintColor = color
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "0%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            progressView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 37),
            progressView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -37),
            progressView.heightAnchor.constraint(equalToConstant: 24),

            progressLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),

        ])
    }

    private func addSubviews() {
        view.addSubview(backView)
        backView.addSubview(progressView)
        progressView.addSubview(progressLabel)
    }

    @objc private func updateTimer() {
        progress += 0.01
        if progress > 1.0 {
            progress = 1.0
            timer?.invalidate()
            timer = nil

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                //                self.performSegue(withIdentifier: "nextScreen", sender: self)
            }
        }
        updateProgress(progress)
    }

    func updateProgress(_ progress: Float) {
        progressView.progress = progress

        let percent = Int(progress * 100)
        progressLabel.text = "\(percent)%"
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xFF0000) >> 16
        let green = (rgbValue & 0x00FF00) >> 8
        let blue = rgbValue & 0x0000FF

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
