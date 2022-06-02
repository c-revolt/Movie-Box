//
//  TitleCollectionViewCell.swift
//  Movie Box
//
//  Created by Александр Прайд on 01.06.2022.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
 
    static let identifire = K.titleCollectionViewCell
    
    private let posterImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
}
// MARK: - Setup UI Elements
extension TitleCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
    }
    
}

// MARK: - Configured with SDWebImages
extension TitleCollectionViewCell {
    
    public func configure(with model: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
        
    }
}
