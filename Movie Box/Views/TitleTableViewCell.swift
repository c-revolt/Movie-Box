//
//  TitleTableViewCell.swift
//  Movie Box
//
//  Created by Александр Прайд on 02.06.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifire = K.titleTableViewCell
    
    private let titlesPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGreen
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: TitleViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        
        
        titlesPosterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }

}

// MARK: - Setup UI Elements
extension TitleTableViewCell {
    
    private func addSubviews() {
        contentView.addSubview(titlesPosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
    }
    
    private func applyContraints() {
        
        NSLayoutConstraint.activate([
            titlesPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlesPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlesPosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImageView.trailingAnchor, constant: 20)
            
        ])
        
        NSLayoutConstraint.activate([
            playTitleButton.leadingAnchor.constraint(equalTo: titlesPosterImageView.trailingAnchor, constant: 20),
            playTitleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            playTitleButton.widthAnchor.constraint(equalToConstant: 70),
            playTitleButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
