//
//  JokeCategoryViewController.swift
//  APILecture
//
//  Created by Misha on 14.07.2026.
//

import UIKit

enum JokeCategory {
    case random
    case career
    case animal

    var title: String {
        switch self {
        case .random: return "Random"
        case .career: return "Career"
        case .animal: return "Animal"
        }
    }

    var param: String {
        switch self {
        case .random: return ""
        case .career: return "category=career"
        case .animal: return "category=animal"
        }
    }

    var accentColor: UIColor {
        switch self {
        case .random: return UIColor(red: 1, green: 0.553, blue: 0.157, alpha: 1)
        case .career: return UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1)
        case .animal: return .systemBlue
        }
    }
}

class JokeCategoryViewController: UIViewController {

    let category: JokeCategory

    private let titleLabel = UILabel()
    private let funFactLabel = UILabel()
    private let spinner = UIActivityIndicatorView(style: .large)
    private let refreshButton = UIButton(type: .system)
    private var apiManager: FunFactAPIManagerProtocol?

    init(category: JokeCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        fetchJoke()
    }

    private func setupUI() {
        titleLabel.text = category.title
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        funFactLabel.text = "Loading..."
        funFactLabel.font = .systemFont(ofSize: 17)
        funFactLabel.textAlignment = .center
        funFactLabel.numberOfLines = 0
        funFactLabel.translatesAutoresizingMaskIntoConstraints = false

        spinner.color = .systemPink
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.title = "New Joke"
        config.baseBackgroundColor = category.accentColor
        refreshButton.configuration = config
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(funFactLabel)
        view.addSubview(spinner)
        view.addSubview(refreshButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),

            funFactLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            funFactLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            funFactLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            refreshButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            refreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            refreshButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64)
        ])
    }

    @objc private func didTapRefresh() {
        fetchJoke()
    }

    private func fetchJoke() {
        spinner.startAnimating()
        funFactLabel.isHidden = true
        refreshButton.isEnabled = false

        apiManager = FunFactAPIManager(param: category.param)
        apiManager?.fetchFunFact { [weak self] funFact in
            self?.funFactLabel.text = funFact.value
            self?.funFactLabel.isHidden = false
            self?.spinner.stopAnimating()
            self?.refreshButton.isEnabled = true
        }
    }
}
