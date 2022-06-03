//
//  SearchResultsViewController.swift
//  Movie Box
//
//  Created by Александр Прайд on 02.06.2022.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    public var titles: [Title] = [Title]()
    
    public let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        
        addSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }

}

extension SearchResultsViewController {
    
    private func addSubviews() {
        view.addSubview(searchResultCollectionView)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "Unknown")
        
        
        return cell
    }
    
    
}
