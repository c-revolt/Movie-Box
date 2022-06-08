//
//  HomeViewController.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomeTrandingMovie: Title?
    private var headerView: TopHeaderUIView?
    
    let sectionTitles: [String] = [K.SectionTitles.trendingMovies, K.SectionTitles.trendingTv, K.SectionTitles.popular, K.SectionTitles.upcomingMovies, K.SectionTitles.topRater]

    private let feedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewInTableViewCell.self, forCellReuseIdentifier: K.collectionViewInTableViewID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        addSubviews()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        headerView = TopHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        feedTableView.tableHeaderView = headerView
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        feedTableView.frame = view.bounds
        
        addSubviews()
        setupUIElements()
        
        
        
    }

}

//MARK: - Setup UI Elements
extension HomeViewController {
    
    private func addSubviews() {
        view.addSubview(feedTableView)
    }
    
    private func setupUIElements() {
        setupNavigationBarItems()
        confugureHeaderView()
    }
    
    private func setupNavigationBarItems() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let logolabel = UILabel()
        logolabel.text = "MOVIE BOX"
        logolabel.textColor = .systemGreen
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logolabel)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func confugureHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self?.randomeTrandingMovie = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? "", overView: selectedTitle?.overview ?? "", rate: selectedTitle?.vote_average ?? 0.0))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

//MARK: - UITableViewDelegate & UITableViewDataSource 
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewInTableViewCell.identifire, for: indexPath) as? CollectionViewInTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                
                }
            }
        case Sections.TrendingTV.rawValue:
            
            APICaller.shared.getTrendingTV { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            
            APICaller.shared.getTopRater { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffSet = view.safeAreaInsets.top
        let offSet = scrollView.contentOffset.y + defaultOffSet
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offSet))
    }
    
}

//MARK: - CollectionViewInTableViewCellDelegate
extension HomeViewController: CollectionViewInTableViewCellDelegate {
    
    func collectionViewInTableViewCellDidTappedCell(_ cell: CollectionViewInTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in 
            let viewController = PreviewViewController()
            viewController.configure(with:  viewModel)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
