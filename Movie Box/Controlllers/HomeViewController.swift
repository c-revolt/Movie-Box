//
//  HomeViewController.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = [K.SectionTitles.popularMovies, K.SectionTitles.top, K.SectionTitles.popularTV, K.SectionTitles.upcomingMovies, K.SectionTitles.topRater]

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
        
        let headerView = TopHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        feedTableView.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        feedTableView.frame = view.bounds
        
        addSubviews()
        setupUIElements()
        
        fetchData()
    }
    
    private func fetchData() {
//        APICaller.shared.gettrandingMovies { results in
//
//            switch results {
//            case .success(let movies):
//                print(movies)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
//        APICaller.shared.getTrandingTV { results in
//        }
        
//        APICaller.shared.getUpComingMovie { results in
//
//        }
        
//        APICaller.shared.getPopular { results in
//
//        }
        
        APICaller.shared.getTopRater { results in 
        }
    }
    

}

//MARK: - Setup UI Elements
extension HomeViewController {
    
    private func addSubviews() {
        view.addSubview(feedTableView)
    }
    
    private func setupUIElements() {
        setupNavigationBarItems()
    }
    
    private func setupNavigationBarItems() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        
        let logolabel = UILabel()
        logolabel.text = "MOVIE BOX"
        logolabel.textColor = .systemYellow
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logolabel)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
        
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.collectionViewInTableViewID, for: indexPath) as? CollectionViewInTableViewCell else {
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
