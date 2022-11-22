//
//  RepositoryListViewController.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

import UIKit

final class RepositoryListViewController: UIViewController {

    // MARK: Module

    typealias ViewModel = RepositoryListViewModelType

    private enum Identifier {
        static let repositoryCell = "repositoryCell"
    }

    private enum Formatter {
        static func starCountNumber(_ starCount: Int) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: starCount))!
        }
    }


    // MARK: Property

    private let viewModel: ViewModel
    private var repositories: [Repository] = []


    // MARK: UI

    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    let loadingIndicator = UIActivityIndicatorView()


    // MARK: Initializer

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        defer { bindWithViewModel() }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }


    // MARK: Configuring

    private func configure() {
        title = "GitHub Search"
        configureTableView()
        configureSearchController()
        configureNavigationItem()
    }


    // MARK: Binding

    private func bindWithViewModel() {
        viewModel.delegate = self
    }

}


// MARK: ViewModel Delegate

extension RepositoryListViewController: RepositoryListViewModelDelegate {

    func setLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
        }
    }

    func showRepositories(_ repositories: [Repository]) {
        DispatchQueue.main.async {
            self.repositories = repositories
            self.tableView.reloadData()
        }
    }

}


// MARK: Layout

extension RepositoryListViewController {

    private func layout() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

}


// MARK: UITableView

extension RepositoryListViewController {

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: Identifier.repositoryCell)
    }

}


// MARK: SearchController

extension RepositoryListViewController {

    private func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
    }
}


// MARK: NavigationItem

extension RepositoryListViewController {

    private func configureNavigationItem() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}


// MARK: UISearchBarDelegate

extension RepositoryListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        viewModel.search(repositoryName: keyword)
    }

}


// MARK: UITableViewDataSource

extension RepositoryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard indexPath.item < repositories.count else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Identifier.repositoryCell,
            for: indexPath
        ) as? RepositoryTableViewCell else { return UITableViewCell() }
        let repository = repositories[indexPath.item]
        cell.setRepository(repository)
        return cell
    }

}


// MARK: UITableViewDelegate

extension RepositoryListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < repositories.count else { return }
        let repository = repositories[indexPath.item]

        let formattedStarCount = Formatter.starCountNumber(repository.stargazersCount)
        let alertController = UIAlertController(
            title: "\(repository.name)",
            message: "\(formattedStarCount) 개",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }

}


// MARK: Testables

#if DEBUG

import Testables

extension RepositoryListViewController: Testable {

    final class TestableKeys: TestableKey<Self> {
        let tableView = \Self.tableView
    }

}

#endif
