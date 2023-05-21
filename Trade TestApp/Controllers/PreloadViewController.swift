//
//  PreloadViewController.swift
//  Trade TestApp
//
//  Created by Aleksandr Ataev on 19.05.2023.
//

import UIKit
import UserNotifications

final class PreloadViewController: UIViewController {

    private let image = UIImage(named: "Back")
    private var progress: Float = 0.0
    private var timer: Timer? = nil
    private let color = UIColor(hex: "60B678")
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()

        progressView.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
        label.font = .boldSystemFont(ofSize: 19)
        label.text = "0%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2),
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

            self.notificationCenter.requestAuthorization(options: [.alert, .sound, .alert]) { (granted, error) in
                guard granted else { return }
                self.notificationCenter.getNotificationSettings { (settings) in
                    guard settings.authorizationStatus == .authorized else { return }
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.navigationController?.pushViewController(self.createTabBarController(), animated: true)
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
