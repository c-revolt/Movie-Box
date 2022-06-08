//
//  UserListViewController.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit

class UserBoxViewController: UIViewController {

    private var titles: [TitleItem] = [TitleItem]()
    
    private let userBoxTableView: UITableView = {
        let table = UITableView()
        table.register(UserBoxTableViewCell.self, forCellReuseIdentifier: UserBoxTableViewCell.identifire)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        userBoxTableView.delegate = self
        userBoxTableView.dataSource = self
        
        addSubviews()
        setupUIElements()
        
        fetchLocalStorageForList()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Added"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForList() 
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userBoxTableView.frame = view.bounds
    }
    
    private func fetchLocalStorageForList() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.userBoxTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
//MARK: - Setup UI Elements
extension UserBoxViewController {
    
    private func addSubviews() {
        view.addSubview(userBoxTableView)
    }
    
    private func setupUIElements() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        title = "My Box"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
        
        navigationController?.navigationBar.tintColor = .systemGreen
    }

}

//MARK: - UITableViewDelegate & UICollectionViewDataSource
extension UserBoxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserBoxTableViewCell.identifire, for: indexPath) as? UserBoxTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_name ?? title.original_title) ?? "Unknown Video", posterURL: title.poster_path ?? "", overView: title.overview ?? "", rate: title.vote_average))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Delete success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        
        
        APICaller.shared.getMoview(with: titleName) { [weak self] result in
            switch result {
            case .success(let ytVideo):
                DispatchQueue.main.async {
                    let viewController = PreviewViewController()
                    viewController.configure(with: TitlePreviewViewModel(youtube: ytVideo, title: titleName, titleOverview: title.overview ?? "", voteAverage: title.vote_average))
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
