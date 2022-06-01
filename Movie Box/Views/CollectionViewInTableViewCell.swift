//
//  CollectionViewInTableViewCell.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit

class CollectionViewInTableViewCell: UITableViewCell {

    static let identifire = K.collectionViewInTableViewID

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: K.collectionViewInTableViewID)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemGreen
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
}

// MARK: - Setup UI Elements
extension CollectionViewInTableViewCell {
    
    private func addSubviews() {
        
        contentView.addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension CollectionViewInTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionViewInTableViewID, for: indexPath)
        
        cell.backgroundColor = .systemPink
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}
