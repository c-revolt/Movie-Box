//
//  SearchViewController.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifire)
        return table
    }()
    
    private let serachController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Find something to watch..."
        controller.searchBar.searchBarStyle = .minimal
        
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        navigationItem.searchController = serachController
        serachController.searchResultsUpdater = self
        
        setupNavigationBar()
        addSubviews()
        applyConstraints()
        
        fetchSearch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchTable.frame = view.bounds
    }
    
    func fetchSearch() {
        
        APICaller.shared.getSearchMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.searchTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    

}

// MARK: - Setup UI Elements
extension SearchViewController {
    
    private func addSubviews() {
        view.addSubview(searchTable)
    }
    
    private func setupUIElements() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        title = "Search"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
        
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    private func applyConstraints() {
        
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifire, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown name", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController
        else { return }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultController.titles = titles
                    resultController.searchResultCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
