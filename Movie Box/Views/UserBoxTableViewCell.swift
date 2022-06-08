//
//  UserBoxTableViewCell.swift
//  Movie Box
//
//  Created by Александр Прайд on 08.06.2022.
//

import UIKit

class UserBoxTableViewCell: UITableViewCell {

    static let identifire = K.userBoxTableViewCell
    
    private let titlesPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGreen.cgColor
        imageView.layer.cornerRadius = 7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overViewlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .systemGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        overViewlabel.text = model.overView
        voteAverageLabel.text = String(model.rate)
    }

}
// MARK: - Setup UI Elements
extension UserBoxTableViewCell {
    
    private func addSubviews() {
        contentView.addSubview(titlesPosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overViewlabel)
        contentView.addSubview(voteAverageLabel)
    }
    
    private func applyContraints() {
        
        NSLayoutConstraint.activate([
            titlesPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            
        ])
        
        NSLayoutConstraint.activate([
            overViewlabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            overViewlabel.leadingAnchor.constraint(equalTo: titlesPosterImageView.trailingAnchor, constant: 10),
            overViewlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            voteAverageLabel.leadingAnchor.constraint(equalTo: titlesPosterImageView.trailingAnchor, constant: 10),
            voteAverageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            voteAverageLabel.widthAnchor.constraint(equalToConstant: 35),
            voteAverageLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
