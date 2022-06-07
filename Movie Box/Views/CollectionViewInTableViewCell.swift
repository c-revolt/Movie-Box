//
//  CollectionViewInTableViewCell.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit


protocol CollectionViewInTableViewCellDelegate: AnyObject {
    func collectionViewInTableViewCellDidTappedCell(_ cell: CollectionViewInTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewInTableViewCell: UITableViewCell {

    static let identifire = K.collectionViewInTableViewID
    private var titles: [Title] = [Title]()
    
    weak var delegate: CollectionViewInTableViewCellDelegate?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
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
    
    private func addToList(indexPath: IndexPath) {
        
        DataPersistenceManager.shared.userBoxTitleWith(model: titles[indexPath.row]) { result in
                
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Added"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - Setup UI Elements
extension CollectionViewInTableViewCell {
    
    private func addSubviews() {
        
        contentView.addSubview(collectionView)
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension CollectionViewInTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getMoview(with: titleName + "trailer") { [weak self] result in
            switch result {
            case .success(let ytVideo):
                
                let title = self?.titles[indexPath.row]
                
                guard let titleOverview = title?.overview else { return }
                guard let strongSelf = self else { return }
                
                let viewModel = TitlePreviewViewModel(youtube: ytVideo, title: titleName, titleOverview: titleOverview)
                self?.delegate?.collectionViewInTableViewCellDidTappedCell(strongSelf, viewModel: viewModel)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
            
            let config = UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: nil) {[weak self] _ in
                    let downloadAction = UIAction(title: "Add to my Box", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                        self?.addToList(indexPath: indexPath)
                    }
                    return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
                }
            
            return config
        }

    
}
